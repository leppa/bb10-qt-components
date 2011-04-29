import QtQuick 1.1
import "./styles" 1.0
import "./behaviors" 1.0

Item {
    id: button

    signal clicked
    property alias pressed: behavior.pressed
    property alias containsMouse: behavior.containsMouse
    property alias checkable: behavior.checkable  // button toggles between checked and !checked
    property alias checked: behavior.checked

    property BasicButtonStyle style: BasicButtonStyle {}

    property string __position: "only"

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        onClicked: button.clicked()
    }
}
