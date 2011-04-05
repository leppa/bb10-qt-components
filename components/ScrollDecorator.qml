import QtQuick 1.0
import "./styles"
import "./styles/default" as DefaultStyles

Item {
    id: scrollDecorator

    property Flickable flickableItem

    anchors.fill: parent

    DefaultStyles.ScrollIndicatorStyle {
        id: defaultStyle
    }

    property ScrollIndicatorStylingProperties styling: ScrollIndicatorStylingProperties {
        content: defaultStyle.content
    }

    property real minimumSize: defaultStyle.minimumWidth
    property variant visibleArea: flickableItem.visibleArea

    Item {
        width: minimumSize
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: minimumSize

        opacity: flickableItem.movingVertically ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 100 } }

        Loader {
            property real offset: Math.round(visibleArea.yPosition * parent.height)
            property real length: Math.min(visibleArea.heightRatio, 1.0) * parent.height
            property real overshoot: Math.max(-offset, 0, offset + length - parent.height)

            y: Math.max(0.0, Math.min(offset, parent.height - minimumSize))

            width: parent.width
            height: Math.max(minimumSize, length - overshoot)

            sourceComponent: styling.content
        }
    }

    Item {
        height: minimumSize
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: minimumSize

        opacity: flickableItem.movingHorizontally ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 100 } }

        Loader {
            property real offset: Math.round(visibleArea.xPosition * parent.width)
            property real length: Math.min(visibleArea.widthRatio, 1.0) * parent.width
            property real overshoot: Math.max(-offset, 0, offset + length - parent.width)

            x: Math.max(0.0, Math.min(offset, parent.width - minimumSize))

            width: Math.max(minimumSize, length - overshoot)
            height: parent.height

            sourceComponent: styling.content
        }
    }
}
