import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.ProgressBar {
    themeStyle {
        backgroundColor: "silver"
        progressColor: "black"
        minimumWidth: 200
        minimumHeight: 16
    }

    Rectangle {
        anchors.fill: parent
        border.width: 1
        opacity: enabled ? 1.0 : 0.7
        color: !widget.indeterminate ?
            style.backgroundColor : "#666666"

        Rectangle {
            border.width: 1
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: style.progressColor
            visible: !widget.indeterminate
            width: Math.round((widget.width - (style.leftMargin + style.rightMargin)) * complete)
        }
    }
}
