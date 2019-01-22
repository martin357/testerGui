import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.1
ApplicationWindow {
    property bool rotate: true
    id: window
    visible: true

    width: rotate ? 480 : 800
    height: rotate ? 800 : 480

    property string prusaOrange: "#ed6b21"
    onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)


    ListModel {
        id: prettyLittleModel
        ListElement { type:"test"; desc:"Connect to the AP"; name: "Wifi"; state: "ok"  }
        ListElement { type:"text"; text:"Lorem ipsum dolor sit amet" }
        ListElement { type:"text"; text:"Lorem ipsum dolor sit amet" }
        ListElement { type:"text"; text:"Lorem ipsum dolor sit amet" }
        ListElement { type:"test"; desc:"Connect to the AP"; name: "Wifi"; state: "ok"  }
        ListElement { type:"text"; text:"Lorem ipsum dolor sit amet" }
        ListElement { type:"text"; text:"Lorem ipsum dolor sit amet" }
        ListElement { type:"text"; text:"Lorem ipsum dolor sit amet" }
        ListElement { type:"text"; text:"Lorem ipsum dolor sit amet" }
        ListElement { type:"test"; desc:"Connect to the AP"; name: "Wifi"; state: "ok"  }
        ListElement { type:"test"; desc:"Connect to the AP"; name: "Wifi"; state: "ok"  }
    }

    Component {
        id: prettyLittleDelegate
        Loader {
            source: {
                switch(type) {
                case "test": return "DelegateTest.qml"
                case "text": return "DelegateText.qml"
                default:
                    console.log("ListElement - uknoswn type: " + type)
                }
            }

        }
    }

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

            ListView {
                x:0
                y:0

                delegate: prettyLittleDelegate
                model: prettyLittleModel
                spacing: 5
                height: 300
                width: 400
                interactive: true
                clip: true
            }

            Button {
                text: "remove first"
                onClicked: {
                    console.log(JSON.stringify(prettyLittleModel.get(2)))
                    prettyLittleModel.remove(2)
                }
            }

            /*

            TextField {

                id: field
                anchors.horizontalCenter: parent.horizontalCenter
                y: 4
                text: "Zlá ovce"
            }
            */

        }
    }
}
