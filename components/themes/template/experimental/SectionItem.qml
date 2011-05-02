import QtQuick 1.1
import QtLabs.components.experimental.styles 1.0

Item {
    id: sectionItem

    implicitWidth: style.minimumWidth
    implicitHeight: style.minimumHeight

    property SectionItemStyle style: SectionItemStyle {
        // colors
        highlightColor: userStyle.highlightColor != "" ?
            userStyle.highlightColor : themeStyle.highlightColor
        backgroundColor: userStyle.backgroundColor != "" ?
            userStyle.backgroundColor : themeStyle.backgroundColor

        // margins
        leftMargin: userStyle.leftMargin != undefined ?
            userStyle.leftMargin : themeStyle.leftMargin
        topMargin: userStyle.topMargin != undefined ?
            userStyle.topMargin : themeStyle.topMargin
        rightMargin: userStyle.rightMargin != undefined ?
            userStyle.rightMargin : themeStyle.rightMargin
        bottomMargin: userStyle.bottomMargin != undefined ?
            userStyle.bottomMargin : themeStyle.bottomMargin

        // minimum size
        minimumWidth: userStyle.minimumWidth != undefined ?
            userStyle.minimumWidth : themeStyle.minimumWidth
        minimumHeight: userStyle.minimumHeight != undefined ?
            userStyle.minimumHeight : themeStyle.minimumHeight
    }

    property SectionItemStyle themeStyle: SectionItemStyle {
        highlightColor: "blue"
        backgroundColor: "white"
        leftMargin: 0
        topMargin: 0
        rightMargin: 0
        bottomMargin: 0
        minimumWidth: 100
        minimumHeight: 46
    }
}
