import QtQuick 1.1
import "./styles"       // BusyIndicatorStylingProperties
import "./styles/default" as DefaultStyles

Item {
    id: busyIndicator

    property bool running: false

    property BusyIndicatorStylingProperties styling: BusyIndicatorStylingProperties {
        background: defaultStyle.background
    }

    // implementation

    implicitWidth: backgroundComponent.item.implicitWidth;
    implicitHeight: backgroundComponent.item.implicitHeight;

    Loader {
        id: backgroundComponent
        property bool running: busyIndicator.opacity > 0 &&
                               busyIndicator.visible &&
                               busyIndicator.running
        anchors.fill: parent
        sourceComponent: styling.background
    }

    DefaultStyles.BusyIndicatorStyle { id: defaultStyle }
}
