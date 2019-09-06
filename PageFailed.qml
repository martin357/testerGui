import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0

Item {
    id:  failed
    Rectangle {
        color: "red"
        anchors.fill: parent
    }
    ColumnLayout {
        anchors.centerIn: parent
        Text {
            color: "white"
            text: "Failed"
            Layout.alignment: Qt.AlignCenter
        }
        /*
        Text {
            color: "white"
            text: "Read QRCode and you are done."
            Layout.alignment: Qt.AlignCenter
        }

        */
        Row {
            Layout.alignment: Qt.AlignCenter
            spacing: 5
            Button {
                text: "Try Again"
                onClicked: {
                    view.currentIndex = 0
                }
            }
            Button {
                text: "Turn off"
                onClicked: {

                    console.log("Turn off not implemented, FIXME")
                }
            }
        }
    }
}
