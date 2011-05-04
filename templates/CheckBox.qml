import QtQuick 1.1

Item {
    id: checkBox

    signal clicked
    property alias pressed: mouseArea.pressed
    property bool checked: false
    property alias containsMouse: mouseArea.containsMouse

    implicitWidth: 32
    implicitHeight: 32

    function __handleChecked() {
        checkBox.checked = !checkBox.checked;
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            __handleChecked();
            checkBox.clicked();
        }
    }
}
