
import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Process 1.0
Page {
    implicitWidth: 800
    implicitHeight: 480
    width: 800
    height: 480
    Rectangle {
        id: bg
        width: 800
        color: "black"
        anchors.fill: parent
        Timer {
            id: readTimer
            interval: 3000
            repeat: true
            running: true
            onTriggered: {
                edit.text += prc.readAllStandardOutput()
                edit.text += prc.readAllStandardError()
            }
        }
        Process {
            id: prc
            onFinished: {
                console.log("program tester.py finished with exitCode: ", exitCode)
                progressBar.value = 1
                btnNext.enabled = true
                btnPickVariant.enabled = true
                //btnStart.enabled = true
                if(exitCode === 0) {
                    bg.color = "green"
                }
                else {
                    bg.color = "red"
                }
            }
            onErrorOccurred: {
                console.log("Could not start tester.sh")
            }
            onStarted: {
                progressBar.value = 0.1
                btnStart.enabled = false
                btnPickVariant.enabled = false
            }
            onReadyReadStandardOutput: {
                edit.text += readAllStandardOutput()
            }
            onReadyReadStandardError: {
                edit.text += readAllStandardError()
            }


        }

        Button {
            id: btnStart
            x: 300
            y: 392
            text: "Start"
            font.pixelSize: 28
            height: 80
            width: 200
            onClicked: {

                prc.start("tester.py", [])
                progressBar.value = 0.05
            }
        }


        Flickable {
             id: flick
             anchors {
                 horizontalCenter: parent.horizontalCenter
             }

             width: 740; height: 360;
             contentWidth: edit.paintedWidth
             contentHeight: edit.paintedHeight
             clip: true

             function ensureVisible(r)
             {
                 if (contentX >= r.x)
                     contentX = r.x;
                 else if (contentX+width <= r.x+r.width)
                     contentX = r.x+r.width-width;
                 if (contentY >= r.y)
                     contentY = r.y;
                 else if (contentY+height <= r.y+r.height)
                     contentY = r.y+r.height-height;
             }

             TextEdit {
                 color: "white"
                 enabled: false
                 id: edit
                 font.pixelSize: 16
                 width: flick.width
                 focus: true
                 wrapMode: TextEdit.Wrap
                 onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                 onTextChanged: {

                     cursorPosition = text.length
                 }
                 text: ""
             }
         }

        Button {
            id: btnPickVariant
            x: 8
            y: 392
            text: "Pick Variant"
            font.pixelSize: 28
            height: 80
            width: 200
            onClicked: view.currentIndex = view.currentIndex - 1
        }
        Button {
            id: btnNext
            x: 592
            y: 392
            text: "Next Board"
            font.pixelSize: 28
            height: 80
            width: 200
            onClicked: {
                progressBar.value = 0
                btnNext.enabled = false
                btnStart.enabled = true
                btnPickVariant.enabled = true
                bg.color = "black"
                edit.text = ""
            }
            enabled: false
        }

        ProgressBar {
            id: progressBar
            anchors.horizontalCenter: parent.horizontalCenter
            y: 360
            width: 800 - 16
            height: 25
            value: 0
            visible: value !== 0
        }
    }
}
