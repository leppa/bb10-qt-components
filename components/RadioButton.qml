import QtQuick 1.1
import "../templates"
import "./styles/default"

RadioButton {
    id: button

    implicitWidth: style.width
    implicitHeight: style.height

    RadioButtonStyle {
        id: style
    }

    Loader {
        id: loader
        sourceComponent: style.background
        anchors.fill: parent
        property alias styledItem: button
    }
}
