import QtQuick 1.1
import "./private"
import "./styles" 1.0

Item {
    id: toggleSwitch

    signal clicked
    property bool pressed: mouseArea.pressed
    property bool checked: false
    property alias containsMouse: mouseArea.containsMouse

    property alias delegate: loader.delegate
    property SwitchStyle style: SwitchStyle {}

    // Implementation

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: toggleSwitch
        property alias userStyle: toggleSwitch.style
        property real handleCenterX: item.handle.x + (item.handle.width / 2.0)

        filepath: Qt.resolvedUrl(theme.path + "Switch.qml");
        Component.onCompleted: item.handle.x = checked ? mouseArea.drag.maximumX : mouseArea.drag.minimumX
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        property Item handle: loader.item.handle

        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: toggleSwitch.width - handle.width
        drag.target: handle

        onPressed: {
            toggleSwitch.pressed = true  // needed when hover is enabled
        }
        onCanceled: {
            snapHandleIntoPlace();
            // mouse stolen e.g. by Flickable
            toggleSwitch.pressed = false;
        }
        onReleased: {
            var wasChecked = checked;
            if (drag.active) {
                checked =  (handle.x > (drag.maximumX - drag.minimumX)/2)
            } else if (toggleSwitch.pressed && enabled) { // No click if release outside area
                checked = !checked;
            }

            snapHandleIntoPlace();

            toggleSwitch.pressed = false
            if(checked != wasChecked)
                toggleSwitch.clicked();
        }
    }

    onWidthChanged: snapHandleIntoPlace()
    onCheckedChanged: snapHandleIntoPlace()

    function snapHandleIntoPlace() {
        if (mouseArea.handle)
            mouseArea.handle.x = checked ? mouseArea.drag.maximumX : mouseArea.drag.minimumX;
    }
}
