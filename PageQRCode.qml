
import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Process 1.0

Page {
    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: 42
        text: "Before anything else,\nscan the QRCode and\nglue it on the board!"
        color: "white"
    }

}
