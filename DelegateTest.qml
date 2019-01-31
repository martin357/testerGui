import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
Rectangle {
    signal clicked()
    signal remove(int index)
    id: root
    color: model.state === "idle" ? "black" : model.state === "running" ? "yellow" : model.state === "ok" ? "green" : model.state === "failed" ? "red" : "purple"
    border.width: 3
    border.color: "white"
    radius: 10
    width: 400
    height: 50
    RowLayout {
        anchors.centerIn: parent
        Text {
            text: model.name
            font.pixelSize: 20
            color: "white"
            Layout.alignment: Qt.AlignCenter
        }
        Text {
            text: model.desc
            font.pixelSize: 20
            color: "white"
            Layout.alignment: Qt.AlignCenter
        }
        RoundButton {
            text: "Remove"
            onClicked: {
                //field.text = index
                root.remove(index)
            }
            radius: 5
        }
        RoundButton {
            text: "Signal"
            onClicked: root.clicked()
            radius: 5
        }

    }

}
