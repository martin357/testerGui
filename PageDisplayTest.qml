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
import Process 1.0

Page {
    id: displayTest

    width: 800
    height: 480

    property int counter: 0
    property var pointButtons: []
    property bool result: false
    property var showButtons: function(what) {
        for(var i in pointButtons) {
            pointButtons[i].visible = what
        }
    }
    property string log: ""

    Component.onCompleted: {
        initialize()
    }
    property var initialize: function() {

        for(var i in pointButtons) {
            pointButtons[i].reset()
        }
        console.debug("onInitializeChanged")
    }
    onPointButtonsChanged: {
        console.log(pointButtons[pointButtons.length -1 ])
    }

    onCounterChanged: {
        if(counter >= 4) {
            for(var i in pointButtons) {
                pointButtons[i].reset()
                pointButtons[i].enabled = false
            }
            counter = 0
            testTimer.stop()
            prc.start("write_display_test_results.py", ["--success"])
            result = true
        }
    }

    Process {
        id: prc

        onFinished: {
            console.log("Process finished with exitCode: ", exitCode)
            if(exitCode === 0) {
                if(result) {
                    view.currentIndex = 1
                }
                else {
                    view.currentIndex = 2
                }
            }
            else {
                internalError.visible = true
            }
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
            log += txt
            console.log("Process read: " + txt)
            if(txt.indexOf("#request_qrcode") !== -1) {
                requestQrcodeBanner.visible = true
                console.log("showing qrcode request")
            }
            if(txt.indexOf("#request_qrcode_done") !== -1) {
                requestQrcodeBanner.visible = false
                console.log("hiding qrcode request")
            }
        }

        onReadyReadStandardError: {
            var txt = readAllStandardError().toString()
            log += txt
            console.log("Process StdErrReady:\n" + txt)
        }
    }
    Rectangle {
        id: internalError
        visible: false
        width: 800
        height: 480
        z: 200
        Rectangle {
            anchors {
                fill: parent
            }
            color: "black"
        }
        Text {
            id: tit
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
            }
            font.pixelSize: 32
            text: "Internal error occured."
            color: "white"
        }
        TextEdit {
            id: err
            enabled: false
            anchors.centerIn: parent
            height: 400
            width: 700
            text: log
            color: "white"
        }
    }
    Rectangle {
        id: requestQrcodeBanner
        visible: false
        anchors {
            centerIn: parent
        }
        z: 99
        width: 700
        height: 100
        color: "black"
        border.color: "yellow"
        border.width: 2
        radius: 5
        opacity: 80
        Text {
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 48
            text: "Scan the QR code"
        }
    }

    Rectangle {
        id: background
        color: "black"
        anchors.fill: parent
    }



    Image {
        id: img
        anchors {
            left: parent.left
            right: parent.right
            bottom:  parent.bottom
            top: parent.top
        }
        source: "qrc://calibration_pattern.png"
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectFit
        z: -1
    }

    Timer {
        property int countDown: 0
        id: testTimer
        interval: 15000
        repeat: false
        triggeredOnStart: false
        onTriggered: {

            for(var i in pointButtons) {
                pointButtons[i].reset()
                pointButtons[i].enabled = false
            }
            counter = 0
            prc.start("write_display_test_results.py", ["--failure"])
            result = false

        }
        onRunningChanged: {
            if(running) {
                countDown = interval
                countDownTimer.start()
            }
            else {
                countDown = interval
                countDownTimer.stop()
            }
        }
    }
    Timer {
        id: countDownTimer
        onTriggered: {
            countDownText.text = testTimer.countDown / 1000
            testTimer.countDown = Math.max(testTimer.countDown - 1000, 0)
        }
        repeat: true
        interval: 1000
        onRunningChanged: {
            if(running) {
                //
            }
            else {
                countDownText.text = testTimer.countDown / 1000
            }
        }

    }

    Button {
        id: startStop
        y: 108
        anchors.horizontalCenter: parent.horizontalCenter
        width: 200
        height: 120
        background: Rectangle {
            color:   startStop.down ? "#666666" : "#999999"
            border.color: prusaOrange
            border.width: 2
            radius: 10
        }

        text: "Start"
        autoRepeat: false
        onClicked: {
            if(! testTimer.running) {
                testTimer.start()
                counter = 0
                for(var i in pointButtons) {
                    pointButtons[i].reset()
                    pointButtons[i].highlight()
                    pointButtons[i].enabled = true
                }
            }
        }
    }

    Text {
        id: countDownText
        anchors {
            top: startStop.bottom
            horizontalCenter: startStop.horizontalCenter
            margins: 50
        }

        font.pixelSize: 48
        text: ""
        color: "white"
    }

    Repeater {
        model: [[0, 0], [760, 0], [0, 440], [760, 440]]
        PointButton {
            x: modelData[0]
            y: modelData[1]
            onClicked: {
                activate()
                if(state == "active") {
                    counter += 1
                }
                enabled = false
            }
            enabled: false
        }
    }





}
