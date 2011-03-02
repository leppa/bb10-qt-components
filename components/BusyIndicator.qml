import QtQuick 1.1
import "./styles/default" as DefaultStyles

Item {
    id: busyIndicator

    property bool running: true
    property Component background: defaultStyle.background

    // implementation

    implicitWidth: backgroundComponent.item.implicitWidth;
    implicitHeight: backgroundComponent.item.implicitHeight;

    Loader {
        id: backgroundComponent
        property bool running: busyIndicator.opacity > 0 &&
                               busyIndicator.visible &&
                               busyIndicator.running
        anchors.fill: parent
        sourceComponent: background
    }

    DefaultStyles.BusyIndicatorStyle { id: defaultStyle }
}
