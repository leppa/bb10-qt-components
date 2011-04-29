import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.Switch {
    handle: handleItem

    themeStyle {
        switchColor: "white"
        backgroundColor: "white"
        positiveHighlightColor: "blue"
        negativeHighlightColor: "transparent"
        textColor: "black"

        minimumWidth: 80
        minimumHeight: 32
        animatedMove: true
    }

    Item {
        anchors.fill: parent
        opacity: enabled ? 1 : 0.7

        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: 5
            color: style.backgroundColor
        }

        Item { // Clipping container of the positive and negative groove highlight
            anchors.fill: parent
            anchors.margins: 2
            clip: true

            Item { // The highlight item is twice the width of there switch, clipped by its parent,
                // and sliding back and forth keeping the center under the handle
                height: parent.height
                width: 2*parent.width
                x: handleCenterX-parent.width-parent.anchors.leftMargin

                Rectangle { // positive background highlight
                    color: style.positiveHighlightColor
                    opacity: 0.8
                    anchors.top: parent.top; anchors.bottom: parent.bottom
                    anchors.left: parent.left; anchors.right: parent.horizontalCenter
                }
                Rectangle { // negative background highlight
                    color: style.negativeHighlightColor
                    opacity: 0.8
                    anchors.top: parent.top; anchors.bottom: parent.bottom
                    anchors.left: parent.horizontalCenter; anchors.right: parent.right
                }
            }
        }

        BorderImage { // Rounded border
            anchors.fill: parent
            source: "images/lineedit_normal.png"
            border { left: 6; right: 6; top: 3; bottom: 3 }
            smooth: true
        }
    }

    Item {
        id: handleItem
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: 42
        Rectangle { // center fill
            anchors.fill: parent
            anchors.margins: 1
            radius: 5
            color: style.switchColor
        }
        BorderImage {
            anchors.fill: parent
            opacity: enabled ? 1 : 0.7
            smooth: true
            source: pressed ? "images/button_pressed.png" : "images/button_normal.png"
            border { left: 4; top: 4; right: 4; bottom: 4 }
        }
        Behavior on x {
            enabled: style.animatedMove
            NumberAnimation { easing.type: Easing.OutCubic; duration: 200 }
        }
    }
}
