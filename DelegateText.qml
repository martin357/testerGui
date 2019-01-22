import QtQuick 2.0
import QtQuick.Controls 2.1
Rectangle {
    id: root
    color: "red"// model.state === "idle" ? "black" : model.state === "running" ? "yellow" : model.state === "ok" ? "green" : model.state === "failed" ? "red" : "purple"
    border.width: 3
    border.color: "white"
    radius: 10
    width: 400
    height: 50
    Text {
        anchors.centerIn: parent
        text: model.text
        font.pixelSize: 20
        color: "white"
    }

}
