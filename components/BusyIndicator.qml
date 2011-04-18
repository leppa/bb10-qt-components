import QtQuick 1.1
import "./styles"       // BusyIndicatorStylingProperties
import "./styles/default" as DefaultStyles

Item {
    id: busyIndicator

    property bool running: false

    // implementation

    implicitWidth: 32
    implicitHeight: 32

    Item{
        id: backgroundComponent
        anchors.fill: parent
        property bool running: busyIndicator.opacity > 0 &&
                               busyIndicator.visible &&
                               busyIndicator.running
    }

    DefaultStyles.BusyIndicatorStyle { id: defaultStyle }
}
