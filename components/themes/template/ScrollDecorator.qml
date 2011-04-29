import QtQuick 1.1
import QtLabs.components.styles 1.0

Item {
    id: template

    property ScrollDecoratorStyle style: ScrollDecoratorStyle {
        borderMargin: userStyle.borderMargin != undefined ?
            userStyle.borderMargin : themeStyle.borderMargin

        minimumSize: userStyle.minimumSize != undefined ?
            userStyle.minimumSize : themeStyle.minimumSize
    }

    property ScrollDecoratorStyle themeStyle: ScrollDecoratorStyle {
        borderMargin: 0
        minimumSize: 1
    }

    property variant visibleArea: flickableItem.visibleArea

    property Component content

    Item {
        width: style.minimumSize
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: style.borderMargin
        anchors.bottomMargin: style.minimumSize

        opacity: flickableItem.movingVertically ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 100 } }

        Loader {
            property real offset: Math.round(visibleArea.yPosition * parent.height)
            property real length: Math.min(visibleArea.heightRatio, 1.0) * parent.height
            property real overshoot: Math.max(-offset, 0, offset + length - parent.height)

            y: Math.max(0.0, Math.min(offset, parent.height - style.minimumSize))

            width: parent.width
            height: Math.max(style.minimumSize, length - overshoot)

            sourceComponent: template.content
        }
    }

    Item {
        height: style.minimumSize
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: style.borderMargin
        anchors.rightMargin: style.minimumSize

        opacity: flickableItem.movingHorizontally ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 100 } }

        Loader {
            property real offset: Math.round(visibleArea.xPosition * parent.width)
            property real length: Math.min(visibleArea.widthRatio, 1.0) * parent.width
            property real overshoot: Math.max(-offset, 0, offset + length - parent.width)

            x: Math.max(0.0, Math.min(offset, parent.width - style.minimumSize))

            width: Math.max(style.minimumSize, length - overshoot)
            height: parent.height

            sourceComponent: template.content
        }
    }
}
