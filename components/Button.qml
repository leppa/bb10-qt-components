import QtQuick 1.1
import "./behaviors"    // ButtonBehavior
import "./styles"     // ButtonStylingProperties
import "./styles/default" as DefaultStyles

Item {
    id: button

    signal clicked
    property alias pressed: behavior.pressed
    property alias containsMouse: behavior.containsMouse
    property alias checkable: behavior.checkable  // button toggles between checked and !checked
    property alias checked: behavior.checked

    property string text
    property url iconSource

    implicitWidth: 100
    implicitHeight: 30

    property ButtonStylingProperties styling: ButtonStylingProperties {
        background: defaultStyle.background
    }

    // implementation

    property string __position: "only"

    Loader {
        id: backgroundLoader
        anchors.fill: parent
        property alias text:button.text
        property alias iconSource:button.iconSource
        sourceComponent: styling.background
        property alias styledItem: button
        property alias position: button.__position
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        onClicked: button.clicked()
    }

    DefaultStyles.ButtonStyle { id: defaultStyle }
}
