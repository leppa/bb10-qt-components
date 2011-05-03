import QtQuick 1.1

Item {
    id: toggleSwitch    // "switch" is a reserved word

    signal clicked
    property bool pressed: mouseArea.pressed
    property bool checked: false
    property alias containsMouse: mouseArea.containsMouse
    default property alias _data: content.data

    property Item handle: null


    // implementation

    implicitWidth: 80
    implicitHeight: 30

    onCheckedChanged: snapHandleIntoPlace();

    Item {
        id: content
        anchors.fill: parent
    }

    Item {
        children: handle
        Component.onCompleted: snapHandleIntoPlace()
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: toggleSwitch.width - handle.width
        drag.target: handle

        onPressed: toggleSwitch.pressed = true  // needed when hover is enabled
        onCanceled: { snapHandleIntoPlace(); toggleSwitch.pressed = false; }   // mouse stolen e.g. by Flickable
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
    function snapHandleIntoPlace() {
        if(handle)
            handle.x = checked ? mouseArea.drag.maximumX : mouseArea.drag.minimumX;
    }
}
