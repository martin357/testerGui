import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Rectangle {
    id: root
    width: 150
    height: 150
    color: mouse.pressed ? "#ed6b21" : background
    //border.width: 3
    radius: 15
    property bool textInside: false
    property int imgRotate: 0
    property int imgMargin: 40
    property alias imgSource: img.source
    property alias text: label.text
    property string background: "#535353"
    property alias showText: label.visible
    property alias imageMargin: root.imgMargin
    property alias textSize: label.font.pixelSize
    signal clicked();

    // On event, emit signal to the socket -> server
    property string page: view.currentItem.slaName
    property string name: "None"
    property bool emitMessages: true
    signal message(string message)

    PrusaText {
        id: label
        visible: true
        anchors {
            margins: 5
            top:  textInside ? img.bottom : root.bottom
            left: parent.left
            right: parent.right
            topMargin:  15
        }

        height: parent.height / 4
        horizontalAlignment: Text.AlignHCenter
    }

    Image {
        id: img
        rotation: parent.imgRotate
        anchors.margins: root.imgMargin//min(root.width, root.height) <= root.imgMargin ? min(root.width, root.height)/4 :  root.imgMargin
        anchors {

            left: parent.left
            right: parent.right
            bottom:  parent.bottom
            top: parent.top
        }

        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: {
            //console.log("Button pressed: " + label.text)
            root.clicked()
        }
        onPressed: {
            if(emitMessages && socket !== undefined) {
                var msg = { "page":root.page, "id":root.name, "pressed":true}
                print("Emitting " + JSON.stringify(msg))
                socket.sendTextMessage(JSON.stringify(msg))

            }

        }
        onReleased: {
            if(emitMessages && socket !== undefined) {
                var msg = { "page":root.page, "id":root.name, "pressed":false}
                print("Emitting " + JSON.stringify(msg))
                socket.sendTextMessage(JSON.stringify(msg))
            }
        }
    }
}
