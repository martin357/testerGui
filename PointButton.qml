/*
    Copyright 2019, Prusa Research s.r.o.

    This file is part of testerGui

    TesterGui is free software: you can redistribute it and/or modify
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

import QtQuick 2.0
import QtQuick.Controls 2.4
Rectangle {

    id: root
    signal clicked;
    property string prusaOrange: "#ed6b21"
    property bool enabled: true
    visible: true

    property var activate: function() {
        root.state = "active"
    }
    property var reset: function() {
        root.state = ""
    }
    property var highlight: function() {
        root.state = "highlight"
    }

    Component.onCompleted: {
        displayTestPage.pointButtons.push(root)
        if(parent.pointButtons !== undefined) {
            parent.pointButtons.push(root)
            console.log("registering the pointButton at ("+ String(x) + ", " + String(y) + ")")
        }

        console.log("print x, y:" + String(x) + ", " + String(y))
    }

    states: [
        State {
            name: "active"
            PropertyChanges {
                target: root.border
                color: "green"
            }
        },
        State {
            name: "highlight"
            PropertyChanges {
                target: anim
                running: true
            }
        }
    ]

    onStateChanged: {
        console.log("state -> " + root.state)
    }

    implicitHeight: 40
    implicitWidth: 40
    color:  "black"
    border.width: 1
    border.color: prusaOrange
    radius: 20
    SequentialAnimation on color{
        id: anim
        alwaysRunToEnd: true
        running: false
        loops: Animation.Infinite
        PropertyAnimation {
            duration: 400
            easing.type: Easing.InOutSine
            to: "green"
        }
        PropertyAnimation {
            duration: 400
            easing.type: Easing.InOutSine
            to: "black"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(root.enabled) {
                root.clicked()
                activate()
            }
        }
    }


}
