import QtQuick 1.1
import QtLabs.components.themes.template.experimental 1.0 as Template

Template.SectionItem {
    themeStyle {
        highlightColor: "#bbbbbb"
        backgroundColor: "#cccccc"
        leftMargin: 10
        rightMargin: 10
        topMargin: 10
        bottomMargin: 10
    }

    Rectangle {
        anchors.fill: parent
        border.width: 1
        border.color: "#444444"
        color: mouseArea.pressed ? style.highlightColor : style.backgroundColor
    }
}
