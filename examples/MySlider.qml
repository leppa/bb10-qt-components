import QtQuick 1.1
import "../components"


Slider {
    id: slider

    height: 30

    Rectangle {
        id: groove
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: 10
        color:  "red"
        border { color: "black"; width: 1 }
    }

    handle: Rectangle {
        width: 25
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        color:  "green"
        border { color: "black"; width: 1 }

        Item {
            visible: slider.pressed
            height: valueLabel.height + 5
            width: valueLabel.width + 5
            anchors.bottom: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 5

            Rectangle {
                anchors.fill: parent
                color: "black"
                opacity: 0.75
                radius: 5
            }

            Text {
                id: valueLabel
                text: slider.formatValue(slider.value)
                anchors.centerIn: parent
                color: "white"
            }
        }
    }
}
