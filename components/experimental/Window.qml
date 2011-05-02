import QtQuick 1.1
import "../private"
import "styles" 1.0

Item {
    id: window

    property alias delegate: loader.delegate
    property WindowStyle style: WindowStyle {}

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: window
        property alias userStyle: window.style
        filepath: Qt.resolvedUrl(theme.path + "experimental/Window.qml")
    }

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight
}
