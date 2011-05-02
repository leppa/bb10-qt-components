import QtQuick 1.1
import "../templates"
import "./styles/default"

BusyIndicator {
    id: busyIndicator

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight

    BusyIndicatorStyle {
        id: style
    }

    Loader {
        id: loader
        sourceComponent: style.background
        anchors.fill: parent
    }
}
