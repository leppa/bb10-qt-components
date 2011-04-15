import QtQuick 1.1
import "./behaviors"
import "./styles"      // CheckBoxStylingProperties
import "./styles/default" as DefaultStyles

Item {
    id: checkBox

    signal clicked
    property alias pressed: behavior.pressed
    property alias checked: behavior.checked
    property alias containsMouse: behavior.containsMouse

    property CheckBoxStylingProperties styling: CheckBoxStylingProperties {
        background: defaultStyle.background
        width: defaultStyle.width
        height: defaultStyle.height
    }

    // implementation
    implicitWidth: styling.width
    implicitHeight: styling.height

    Loader {
        id: backgroundLoader
        anchors.fill: parent
        property alias styledItem: checkBox
        sourceComponent: styling.background
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        checkable: true
        onClicked: checkBox.clicked()
    }

    DefaultStyles.CheckBoxStyle { id: defaultStyle }
}
