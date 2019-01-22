import QtQuick 2.0

Text {
    //property string dtext: undefined
    PrusaFont {id: prusaFont}
    font.pixelSize: 24
    color: "white"
    font.family: prusaFont !== undefined ? prusaFont.name : font.family
    text: ""
}
