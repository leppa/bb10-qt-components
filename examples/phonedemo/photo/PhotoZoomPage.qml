import QtQuick 1.1
import "../widgets"
import "../../../components"

Page {
    id: zoomPage
    title: "Photo Zoom"

    property url imagePath

    Flickable {
        id: flickable
        clip: true
        anchors.fill: parent
        contentWidth: image.width
        contentHeight: image.height

        Image {
            id: image
            source: imagePath
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}
