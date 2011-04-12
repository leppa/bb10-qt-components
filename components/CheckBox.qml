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
        checkmark: defaultStyle.checkmark

        minimumWidth: defaultStyle.minimumWidth
        minimumHeight: defaultStyle.minimumHeight
    }

    // implementation

    implicitWidth: styling.minimumWidth
    implicitHeight: styling.minimumHeight

    Loader {
        id: backgroundLoader
        anchors.fill: parent
        property alias styledItem: checkBox
        sourceComponent: styling.background
    }

    Loader {
        id: checkmarkLoader
        anchors.centerIn: parent
        property alias styledItem: checkBox
        sourceComponent: styling.checkmark
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        checkable: true
        onClicked: checkBox.clicked()
    }

    DefaultStyles.CheckBoxStyle { id: defaultStyle }
    SystemPalette { id: syspal }
}
