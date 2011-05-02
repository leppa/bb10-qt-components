import QtQuick 1.1
import QtLabs.components.themes.template.experimental 1.0 as Template

Template.SectionItem {
    themeStyle {
        highlightColor: "blue"
        backgroundColor: "#cccccc"
        leftMargin: 10
        rightMargin: 10
        topMargin: 6
        bottomMargin: 10
        minimumHeight: 50
    }

    Item {
        clip: true
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            property bool isCenter: (widget.__position == "center")

            radius: isCenter ? 0 : 10
            color: mouseArea.pressed ? style.highlightColor : style.backgroundColor
            anchors.topMargin: (isCenter || widget.__position == "bottom") ? -10 : 0
            anchors.bottomMargin: (isCenter || widget.__position == "top") ? -10 : 0
        }
    }

    Rectangle {
        height: 1
        color: "gray"
        opacity: 0.5
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: widget.__position != "bottom"
    }
}
