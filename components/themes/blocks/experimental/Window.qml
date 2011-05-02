import QtQuick 1.1
import QtLabs.components.themes.template.experimental 1.0 as Template

Template.Window {
    themeStyle.backgroundColor: "#dddddd"

    Rectangle {
        anchors.fill: parent
        color: style.backgroundColor
    }
}
