import QtQuick 1.1

Item {
    id: button

    signal clicked
    property alias pressed: mouseArea.pressed
    property alias containsMouse: mouseArea.containsMouse
    property bool checkable: false
    property bool checked: false

    property string text
    property url iconSource

    implicitWidth: 100
    implicitHeight: 30

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            if (button.checkable)
                button.checked = !button.checked;
            button.clicked();
        }
    }
}
