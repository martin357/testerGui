import QtQuick 2.0
import QtQuick.Controls 2.1
Item {
    id: root
    property alias checked: sw.checked
    property alias checkable: sw.checkable
    property string name: "PrusaSwitch_anonymous"
    height: content.height
    width: content.width
    Row {
        id: content
        anchors.centerIn: parent
        PrusaText { text: "Off"; anchors.margins: 5; color: ! sw.checked ? "white":"black"}

        Switch {
            id: sw
            onCheckedChanged: {
                onPressed: {
                    var msg = { "page":root.page, "id":root.name, "pressed":true}
                    socket.sendTextMessage(JSON.stringify(msg))
                    print("Emitting " + JSON.stringify(msg))
                    msg["pressed"] = false
                    socket.sendTextMessage(JSON.stringify(msg))
                    print("Emitting " + JSON.stringify(msg))

                }
            }
        }

        PrusaText { text: "On"; anchors.margins: 5;  color: sw.checked ? "white":"black" }
    }
}
