import QtQuick 1.1
import "../components"
import "../components/styles/default"

Switch {
    id: sw

    Loader {
        id: grooveLoader
        anchors.fill: parent
        property alias styledItem: sw
        property real handleCenterX: handle.x + (handle.width/2)
        sourceComponent: style.groove
    }

    SwitchStyle {
        id: style
    }

    handle: Loader {
        id: handleLoader
        height: sw.height
        property alias styledItem: sw
        sourceComponent: style.handle
    }
}
