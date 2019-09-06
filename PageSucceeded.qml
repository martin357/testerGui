import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
Item {
    id:  succeeded



    Rectangle {
        color: "green"
        anchors.fill: parent
    }
    Row {
        anchors.centerIn: parent
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
