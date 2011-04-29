import QtQuick 1.1
import "./private"
import "./styles" 1.0

Item {
    id: busyIndicator

    property bool running: false

    property alias delegate: loader.delegate
    property BusyIndicatorStyle style: BusyIndicatorStyle {}

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: busyIndicator
        property alias userStyle: busyIndicator.style
        filepath: Qt.resolvedUrl(theme.path + "BusyIndicator.qml")
    }

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight
}
