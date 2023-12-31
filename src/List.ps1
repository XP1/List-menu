function sortNaturally {
    [Regex]::replace($_, "\d+", {
        $args[0].value.padLeft(20)
    })
}

function writeList {
    param(
        [parameter(mandatory = $true)]
        [string] $text = $null
    )

    $filePath = "$env:Temp\List.txt"
    $text > "$filePath"
    notepad "$filePath" | out-null
    del "$filePath"
}

function listFiles {
    param(
        [switch] $recurse = $false
    )

    get-childItem -name -recurse:$recurse -force | sort-object $function:sortNaturally | out-string
}

function listTree {
    tree /f
}

# https://github.com/PowerShell/PowerShell/blob/master/src/Microsoft.PowerShell.ConsoleHost/host/msh/ConsoleControl.cs#L2785
function lengthInBufferCells {
    param (
        [char] $c
    )

    $isWide = ($c -ge 0x1100 -and (
        ($c -ge 0x1100 -and $c -le 0x115F) -or # Hangul Jamo init. consonants.
        ($c -eq 0x2329 -or $c -eq 0x232A) -or
        ($c -ge 0x2E80 -and $c -le 0xA4CF -and $c -ne 0x303F) -or # CJK ... Yi.
        ($c -ge 0xAC00 -and $c -le 0xD7A3) -or # Hangul syllables.
        ($c -ge 0xF900 -and $c -le 0xFAFF) -or # CJK compatibility ideographs.
        ($c -ge 0xFE10 -and $c -le 0xFE19) -or # Vertical forms.
        ($c -ge 0xFE30 -and $c -le 0xFE6F) -or # CJK compatibility forms.
        ($c -ge 0xFF00 -and $c -le 0xFF60) -or # Full-width forms.
        ($c -ge 0xFFE0 -and $c -le 0xFFE6)
    ))

    (1 + [int] $isWide)
}

function setMaxBufferSize {
    $rawUi = $host.ui.rawUi
    $rawUi.bufferSize = new-object System.Management.Automation.Host.Size(200, 32766)
}

function getBufferText {
    $rawUi = $host.ui.rawUi
    $width = [Math]::max($rawUi.bufferSize.width, 0)
    $height = [Math]::max($rawUi.cursorPosition.y, 0)
    $rectangle = new-object System.Management.Automation.Host.Rectangle(0, 0, $width, $height)
    $buffer = $rawUi.getBufferContents($rectangle)

    $lines = new-object System.Text.StringBuilder
    $characters = new-object System.Text.StringBuilder

    for ($row = 0; $row -lt $height; $row += 1) {
        $cellLength = 0
        for ($column = 0; $column -lt $width; $column += [Math]::max($cellLength, 1)) {
            $cell = $buffer[$row, $column]

            $character = $cell.character
            $characters.append($character) | out-null

            $cellLength = lengthInBufferCells($character)
        }

        $lines.appendLine($characters.toString()) | out-null
        $characters.length = 0
    }

    $lines.toString() -replace "[ \0]*\r?\n", "`r`n"
}

function isCodePageUtf8 {
    $registryPath = "HKLM:\System\CurrentControlSet\Control\Nls\CodePage"
    $codePageName = "OEMCP"
    $codePageValue = "65001"

    ((get-itemProperty -path $registryPath -name $codePageName).$codePageName -eq $codePageValue)
}

function main {
    param(
        [parameter(mandatory = $true)]
        [string] $type = $null,

        [parameter(mandatory = $true)]
        [string] $directory = $null
    )

    $OutputEncoding = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = $OutputEncoding
    $PSDefaultParameterValues["out-file:encoding"] = "utf8"

    set-location -literalPath "$directory"

    $typeFunction = @{
        "files" = { writeList -text $(listFiles) };
        "filesRecursively" = { writeList -text $(listFiles -recurse) };
        "tree" = {
            $result = $null
            if (isCodePageUtf8) {
                $result = listTree | out-string
            } else {
                setMaxBufferSize
                listTree
                $result = getBufferText
            }

            writeList -text $result
        }
    }

    &($typeFunction.get_item($type))
}

main @args