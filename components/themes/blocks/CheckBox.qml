import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.CheckBox {
    themeStyle {
        minimumWidth: 32
        minimumHeight: 32
        backgroundColor: "silver"
    }

    Rectangle {
        anchors.fill: parent
        border.width: 1
        opacity: enabled ? 1.0 : 0.7
        color: style.backgroundColor

        Rectangle {
            anchors.fill: parent
            color: "black"
            anchors.margins: 6
            visible: widget.checked
        }
    }
}
