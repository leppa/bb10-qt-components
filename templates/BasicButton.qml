import QtQuick 1.1
import "./behaviors"    // ButtonBehavior
import "./styles"     // BasicButtonStylingProperties
import "./styles/default" as DefaultStyles

Item {
    id: button

    signal clicked
    property alias pressed: behavior.pressed
    property alias containsMouse: behavior.containsMouse
    property alias checkable: behavior.checkable  // button toggles between checked and !checked
    property alias checked: behavior.checked
    default property alias data: content.data

    // implementation

    property string __position: "only"

    Item {
        id: content
        anchors.fill: parent
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        onClicked: button.clicked()
    }
}
