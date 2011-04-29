import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.Slider {
    themeStyle {
        progressColor: "black"
        backgroundColor: "silver"
        pinWidth: 30
        minimumWidth: 200
        minimumHeight: 30
    }

    opacity: enabled ? 1.0 : 0.7

    groove: Item {
        Rectangle {
            height: 10
            radius: 5
            border.width: 1
            width: parent.width
            color: style.backgroundColor
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle {
            height: 10
            x: handlePosition
            color: style.progressColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    handle: Rectangle {
        width: 30
        height: 30
        color: "black"
        radius: 18
        smooth: true
    }

    valueIndicator: Text {
        text: indicatorText
        visible: mouseArea.pressed
    }
}
