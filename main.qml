import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
ApplicationWindow {
    property bool rotate: true
    id: window
    visible: true

    width: rotate ? 480 : 800
    height: rotate ? 800 : 480

    property string prusaOrange: "#ed6b21"
    onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)




    Page {
        anchors.centerIn: parent
        width: window.rotate ?  parent.height : parent.width
        height: window.rotate ? parent.width : parent.height
        rotation: window.rotate ? 90 : 0
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
                PageSelectVariant {}
                PageTesting {}
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
