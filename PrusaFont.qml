import QtQuick 2.0

FontLoader {
    id: prusaFont;
    source: "fonts/black_grotesk/AtlasGrotesk-Light.otf"
    onStatusChanged: {
        if(prusaFont.status == FontLoader.Ready) console.log("Prusa Font status changed: Ready");
        else if(prusaFont.status == FontLoader.Error) console.log("Prusa Font status changed: Error");
        else if(prusaFont.status == FontLoader.Loading) console.log("Prusa Font status changed: Loading");
        else if(prusaFont.status == FontLoader.Null) console.log("Prusa Font status changed: Null");
        else console.log("FontLoader - control should never reach this place")
    }
}
