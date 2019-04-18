
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

        Rectangle {
            property string txt: ""
            id: banner
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -150
            width: 500
            height: 250
            visible: txt !== ""
            color: "black"
            border.color: "yellow"
            border.width: 3
            radius: 5
            z: 50

            Text {
                color: "white"
                text: parent.txt
                font.bold: true
                font.pixelSize: 32
                anchors.centerIn: parent
            }
        }

        Timer {
            id: readTimer
            interval: 3000
            repeat: true
            running: true
            onTriggered: {
                /*var stdout_var = prc.readAllStandardOutput().toString()
                var stderr_var = prc.readAllStandardError().toString()

                if(stdout_var.indexOf("#request_qrcode") !== -1) {
                    bg.color = "yellow"
                }
                if(stdout_var.indexOf("#request_qrcode_done") !== -1) {
                    bg.color = "black"
                }
                console.log(stdout_var)
                edit.text += stdout_var
                edit.text += stderr_var
                */
                var txt = prc.readAll().toString()
                console.log("new text: " + txt)
                edit.text += txt
                if(txt.indexOf("#request_qrcode") != -1) {
                    bg.color = "yellow"
                }
                if(txt.indexOf("#request_qrcode_done") != -1) {
                    bg.color = "black"
                }
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
            onBytesWritten: {
                console.log("bytesWritten")
            }
            onError: {
                print("error")
            }
            onStateChanged: {
                console.log("StateChanged:" + state )
            }

            onErrorOccurred: {
                console.log("Could not start")
            }
            onStarted: {
                progressBar.value = 0.2
                btnStart.enabled = false
                btnPickVariant.enabled = false
                console.log("Process Started")
            }
            onReadyRead: {
                var txt = readAll().toString()
                console.log("Process read: " + txt)
                edit.text += txt
                if(txt.indexOf("request_qrcode") != -1) {
                    //bg.color = "orange"
                    banner.txt = "Scan the QRCode"
                }
                if(txt.indexOf("request_qrcode_done") != -1) {
                    //bg.color = "black"
                    banner.txt = ""
                }
            }

            onReadyReadStandardError: {
                console.log("Process StdErrReady")
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
                console.log("Start clicked, selected board: " + root.selected.name)
                console.log(JSON.stringify(root.selected))
                switch(root.selected.name) {
                case "a64_v1_2":
                case "a64_v1_3":
                    prc.start("/usr/bin/tester.py", [])
                    progressBar.value = 0.05
                    break
                case "mcu_v5":
                    prc.start("flash_mcu.py", ["--rev", "5"])
                    progressBar.value = 0.05
                    break;
                case "mcu_v6":
                    prc.start("flash_mcu.py", ["--rev", "6"])
                    progressBar.value = 0.05
                    break;

                case "cw1_v1":
                    prc.start("flash_cw1.py", [])
                    progressBar.value = 0.05
                    break;
                default:
                    edit.text = "Unsupported board, this is a problem with the tester software, please contact me on Slack: Martin Kopecky(vyvoj)"
                    break;
                }
            }
        }

        Rectangle {
            color: "#313131"
            opacity: 0.4
            width: 150
            height: 50
            radius: 10
            anchors {
                right: parent.right
                top:parent.top
            }

            Text {
                font.pixelSize: 28
                color: "white"
                anchors.centerIn: parent
                text:  root.selected.name
                Timer {
                    interval: 1000
                    repeat: true
                    running: true
                    onTriggered: {
                        parent.text = root.selected.name
                    }
                }
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
            onClicked: {
                btnNext.onClicked() // cleanup
                view.currentIndex = view.currentIndex - 1
            }
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
