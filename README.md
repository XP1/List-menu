# List menu
Right-click list menu for files and tree list output on Windows.

![ListTree1](https://github.com/XP1/List-menu/assets/776585/ef57db4c-c5a8-4cd1-8a1e-bfc38192e3a7)

## Installation
Run `Install list menu.bat` as administrator.

## Test cases
### Tree
    mkdir "Erika szobája"
    $null | Set-Content "Erika szobája/cover.jpg"
    $null | Set-Content "Erika szobája/Erika szobája.m3u"
    $null | Set-Content "Erika szobája/Kátai Tamás - 01 Télvíz.ogg"
    $null | Set-Content "Erika szobája/Kátai Tamás - 02 Zölderdõ.ogg"
    $null | Set-Content "Erika szobája/Kátai Tamás - 03 Renoir kertje.ogg"
    $null | Set-Content "Erika szobája/Kátai Tamás - 04 Esõben szaladtál.ogg"
    $null | Set-Content "Erika szobája/Kátai Tamás - 05 Ázik az út.ogg"
    $null | Set-Content "Erika szobája/Kátai Tamás - 06 Sûrû völgyek takaród.ogg"
    $null | Set-Content "Erika szobája/Kátai Tamás - 07 Õszhozó.ogg"
    $null | Set-Content "Erika szobája/Kátai Tamás - 08 Mécsvilág.ogg"
    $null | Set-Content "Erika szobája/Kátai Tamás - 09 Zúzmara.ogg"

### Output:
    Folder PATH listing
    Volume serial number is 00000000 0000:0000
    C:.
    │   create.ps1
    │   tree.txt
    │   
    └───Erika szobája
            cover.jpg
            Erika szobája.m3u
            Kátai Tamás - 01 Télvíz.ogg
            Kátai Tamás - 02 Zölderdo.ogg
            Kátai Tamás - 03 Renoir kertje.ogg
            Kátai Tamás - 04 Esoben szaladtál.ogg
            Kátai Tamás - 05 Azik az út.ogg
            Kátai Tamás - 06 Sûrû völgyek takaród.ogg
            Kátai Tamás - 07 Oszhozó.ogg
            Kátai Tamás - 08 Mécsvilág.ogg
            Kátai Tamás - 09 Zúzmara.ogg

### CJK
    $null | Set-Content "欲速则不达.txt"
    $null | Set-Content "爱不是占有,是欣赏.txt"
    $null | Set-Content "您先请是礼貌.txt"
    $null | Set-Content "萝卜青菜，各有所爱.txt"
    $null | Set-Content "广交友，无深交.txt"
    $null | Set-Content "一见钟情.txt"
    $null | Set-Content "山雨欲来风满楼.txt"
    
    $null | Set-Content "悪妻は百年の不作。.txt"
    $null | Set-Content "残り物には福がある。.txt"
    $null | Set-Content "虎穴に入らずんば虎子を得ず。.txt"
    $null | Set-Content "夏炉冬扇.txt"
    $null | Set-Content "花鳥風月.txt"
    $null | Set-Content "起死回生.txt"
    $null | Set-Content "自業自得.txt"
    
    $null | Set-Content "아는 길도 물어가라.txt"
    $null | Set-Content "빈 수레가 요란하다.txt"
    $null | Set-Content "방귀뀐 놈이 성낸다.txt"
    $null | Set-Content "뜻이 있는 곳에 길이 있다.txt"
    $null | Set-Content "콩 심은데 콩나고, 팥 심은데 팥난다.txt"
