import QtQuick 2.4
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
            onClicked: {
                if(root.selected.name == "settings") {
                     view.currentIndex = 2;
                }
                else {

                    view.currentIndex = view.currentIndex +1
                }
            }

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
            /*
            MyRadioButton {
                checked: false
                text: qsTr("PrusaA64 V1.1")
                Layout.alignment: Qt.AlignHCenter
            }
            */
            /*
            MyRadioButton {
                text: qsTr("PrusaA64 V1.2")
                //Layout.alignment: Qt.AlignHCenter
                checked: false
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "a64_v1_2"

                    }
                }
            }*/
            MyRadioButton {
                text: qsTr("PrusaA64 V1.3")
                //Layout.alignment: Qt.AlignHCenter
                checked: true
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "a64_v1_3"
                    }
                }
            }
            MyRadioButton {
                text: qsTr("Motion Controller rev5")
                //Layout.alignment: Qt.AlignHCenter
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "mcu_v5"
                    }
                }
                checked: false
            }
            MyRadioButton {
                text: qsTr("Motion Controller rev6")
                //Layout.alignment: Qt.AlignHCenter
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "mcu_v6"
                    }
                }
                checked: false
            }
            MyRadioButton {
                text: qsTr("CW1")
                //Layout.alignment: Qt.AlignHCenter
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "cw1_v1"
                    }
                }
                checked: false
            }
            MyRadioButton {
                text: qsTr("Settings")
                //Layout.alignment: Qt.AlignHCenter
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "settings"
                    }
                }
                checked: false
            }



        }

    }

}
