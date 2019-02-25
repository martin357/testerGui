import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
Page {

    Rectangle {
        id: r1
        color: "black"
        anchors.fill: parent
        Button {
            text: "Next"
            font.pixelSize: 28
            x: 592
            y: 392
            height: 80
            width: 200
           /* anchors {

                bottom: r1.bottom
                right: r1.right
                margins: 5

            }*/
            onClicked: view.currentIndex = view.currentIndex +1
            z: 10
        }
        ColumnLayout {
            y: 20
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            Text {
                font {
                    pixelSize: 32
                }
                color: "white"
                text: "Pick the board variant:"
                Layout.alignment: Qt.AlignHCenter
            }
            Item {
                height: 30
            }

            MyRadioButton {
                checked: false
                text: qsTr("V1.1")
                Layout.alignment: Qt.AlignHCenter
            }
            MyRadioButton {
                text: qsTr("V1.2")
                Layout.alignment: Qt.AlignHCenter
                checked: false
            }
            MyRadioButton {
                text: qsTr("V1.3")
                Layout.alignment: Qt.AlignHCenter
                checked: true
            }
        }

    }

}
