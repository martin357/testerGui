import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Process 1.0
import Native 1.0
Page {
    background: Rectangle { color: "black" }
    Button {
        x: 8
        y: 392
        anchors.margins: 10
        width: 200
        height: 80
        text: qsTr("Home")

        onClicked: {
            view.currentIndex = 0
        }
        z: 10



    }

    ListView {
        anchors {
            fill: parent
            margins: 20
            bottomMargin: 100
        }
        interactive: true


        Item {
            width: parent.width
            height: txtIp.height + 10

            Text {
                id: txtIp
                anchors.centerIn: parent
                color: "green"
                text: "IPs:\n" + AppInfo.IPs
                font.pixelSize: 16
            }

            Rectangle {
                color: "grey"
                width: parent.width
                height: 2
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
            }
        }
        // ------------------------------------------------------------------
        /*
        Item {
            width: parent.width
            height: txtIp.height + 10
            MyCheckbox {
                text: "Dry Run - don\'t burn EFUSES, will still write to the database"

            }

            Rectangle {
                color: "grey"
                width: parent.width
                height: 2
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
            }
        }
        */
    }


    Process {
        id: ipGetter

        onFinished: {
        }
        onBytesWritten: {
            console.log("bytesWritten")
        }
        onError: {
            console.log("error")
        }
        onStateChanged: {
            console.log("StateChanged:" + state )
        }

        onErrorOccurred: {
            console.log("Could not start")
        }
        onStarted: {
            console.log("Process Started")
        }
        onReadyRead: {
            var txt = readAll().toString()
        }

        onReadyReadStandardError: {
            console.log("Process StdErrReady")
        }


    }
}
