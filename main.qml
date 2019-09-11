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

import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtMultimedia 5.9

ApplicationWindow {
    property bool rotate: true
    id: window
    visible: true

    width: rotate ? 480 : 800
    height: rotate ? 800 : 480

    property string prusaOrange: "#ed6b21"
    onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)

    Component.onCompleted: {
        infiniteSound.play()
    }

    SoundEffect {
         id: infiniteSound
         source: "saraafonso__arp-sample-001-sara-afonso.wav"
         loops: SoundEffect.Infinite
     }


    Page {
        id: root
        // A place to save info about the selected board, at least the name
        // a64_v1_1, a64_v1_2, a64_v1_3, mcu_v4, mcu_v5, mcu_v6, cw1_v1
        property var selected: {"name": "a64_v1_3"}

        anchors.centerIn: parent
        width: window.rotate ?  parent.height : parent.width
        height: window.rotate ? parent.width : parent.height
        rotation: window.rotate ? 270 : 0
        Rectangle {
            color: "black"
            anchors.fill: parent
        }

        InputPanel {
            id: inputPanel
            z: 99
            x: 0
            y: parent.height
            width: parent.width

            states: State {
                name: "visible"
                when: inputPanel.active
                PropertyChanges {
                    target: inputPanel
                    y: parent.height - inputPanel.height
                }

                PropertyChanges {
                    target: flickable
                    contentY: inputPanel.height > (parent.height - activeFocusItem.y) ? inputPanel.height : flickable.contentY
                }
            }
            transitions: [
                Transition {
                    from: ""
                    to: "visible"
                    reversible: true
                    ParallelAnimation {
                        NumberAnimation {
                            properties: "y"
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                        NumberAnimation {
                            properties: "contentY"
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }


                    }
                }
            ]
        }
        Flickable {
            id: flickable
            anchors.fill: parent
            contentHeight: height + inputPanel.height
            contentWidth: width
            interactive: false

            // Actual content
            SwipeView {
                id: view
                anchors.fill: parent
                currentIndex: 0
                interactive: false
                //PageSelectVariant {id: selectVariantPage}
                //PageTesting {id: testingPage }
                //PageSettings {id: settingsPage }
                PageDisplayTest {id: displayTestPage }
                PageSucceeded { id: succeedPage }
                PageFailed { id: failedPage }

                Page {
                    Rectangle {
                        color: "red"
                        anchors.fill: parent
                    }
                }
            }

        }
    }
}
