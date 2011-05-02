import QtQuick 1.1
import "./behaviors"    // ButtonBehavior

Item {
    id: button

    signal clicked
    property alias pressed: behavior.pressed
    property alias containsMouse: behavior.containsMouse
    property alias checkable: behavior.checkable  // button toggles between checked and !checked
    property alias checked: behavior.checked
    default property alias data: contentItem.data

    property string text
    property url iconSource

    implicitWidth: 100
    implicitHeight: 30

    property string __position: "only"

    Item {
        id: contentItem
        anchors.fill: parent
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        onClicked: button.clicked()
    }
}
