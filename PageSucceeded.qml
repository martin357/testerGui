import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.VirtualKeyboard 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import Process 1.0
Item {
    id:  succeeded


    Process {
        id: prc

        onFinished: {
            console.log("Process finished with exitCode: ", exitCode)
        }

        onBytesWritten: {
            console.log("Process bytesWritten")
        }

        onError: {
            print("Process error")

        }

        onStateChanged: {
            console.log("Process StateChanged:" + state )
        }

        onErrorOccurred: {
            console.log("Could not start program")
        }

        onStarted: {
            console.log("Process Started")
        }

        onReadyRead: {
            var txt = readAll().toString()
            console.log("Process read: " + txt)
        }

        onReadyReadStandardError: {
            var txt = readAllStandardError().toString()
            console.log("Process StdErrReady:\n" + txt)
        }
    }
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
        /*
        Button {
            text: "Turn off"
            onClicked: {
                prc.start("halt", [])
                console.log("Turn off not implemented, FIXME")
            }
        }
        */
    }
}
