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

    property BasicButtonStylingProperties styling: BasicButtonStylingProperties {
        textColor: "black"
        background: defaultStyle.background
    }

    // implementation

    property string __position: "only"

    Loader {
        id: backgroundLoader
        anchors.fill: parent
        sourceComponent: styling.background
        property alias styledItem: button
        property alias position: button.__position
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        onClicked: button.clicked()
    }

    DefaultStyles.BasicButtonStyle { id: defaultStyle }
}
