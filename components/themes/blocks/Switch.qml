import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.Switch {
    id: switcher
    handle: handleItem

    themeStyle {
        textColor: "black"
        switchColor: "black"
        backgroundColor: "silver"
        positiveHighlightColor: "#004400"
        negativeHighlightColor: "transparent"
        minimumWidth: 80
        minimumHeight: 32
        animatedMove: true
    }

    opacity: enabled ? 1 : 0.7

    Rectangle {
        anchors.fill: parent
        color: style.backgroundColor
    }

    Item {
        clip: true
        anchors.fill: parent

        Rectangle {
            width: handleItem.width
            height: handleItem.height
            anchors.right: handleItem.left
            color: style.positiveHighlightColor
        }
        Rectangle {
            width: handleItem.width
            height: handleItem.height
            anchors.left: handleItem.right
            color: style.negativeHighlightColor
        }
        Item {
            id: handleItem
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: switcher.width / 2.0

            Rectangle {
                anchors.fill: parent
                color: style.switchColor
            }
            Behavior on x {
                enabled: style.animatedMove
                NumberAnimation { easing.type: Easing.OutCubic; duration: 200 }
            }
        }
    }
}
