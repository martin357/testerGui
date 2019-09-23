/*
    Copyright 2019, Prusa Research s.r.o.

    This file is part of testerGui

    testerGui is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
Page {
    id: pageSelectVariant
    Rectangle {
        id: r1
        color: "black"
        anchors.fill: parent
        Button {
            text: qsTr("Next")
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
                text: qsTr("Pick the board variant:")
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

            /*
            MyRadioButton {
                text: qsTr("PrusaA64 V1.3")
                checked: true
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "a64_v1_3"
                    }
                }
            }
            */
            MyRadioButton {
                text: qsTr("PrusaA64 V1.3a")
                checked: true
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "a64_v1_3a"
                    }
                }
            }



            /*
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
            */

            MyRadioButton {
                text: qsTr("Motion Controller rev6 C")
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "mcu_v6c"
                    }
                }
                checked: false
            }
            MyRadioButton {
                text: qsTr("CW1")
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "cw1_v1"
                    }
                }
                checked: false
            }
//            MyRadioButton {
//                text: qsTr("PrusaA64 V1.3 Kit")
//                checked: false
//                onCheckedChanged: {
//                    if(checked) {
//                        root.selected.name = "a64_v1_3_kit"
//                    }
//                }
//            }
            MyRadioButton {
                text: qsTr("PrusaA64 V1.3a Kit")
                checked: false
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "a64_v1_3a_kit"
                    }
                }
            }

//            MyRadioButton {
//                text: qsTr("PrusaA64 V1.3 Repair")
//                checked: false
//                onCheckedChanged: {
//                    if(checked) {
//                        root.selected.name = "a64_v1_3_repair"
//                    }
//                }
//            }
            MyRadioButton {
                text: qsTr("PrusaA64 V1.3 Repair")
                checked: false
                onCheckedChanged: {
                    if(checked) {
                        root.selected.name = "a64_v1_3a_repair"
                    }
                }
            }
            MyRadioButton {
                text: qsTr("Settings")
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
