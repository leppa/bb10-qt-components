import QtQuick 1.1
import QtLabs.components.styles 1.0

Item {
    implicitWidth: style.minimumWidth
    implicitHeight: style.minimumHeight

    property ProgressBarStyle style: ProgressBarStyle {
        backgroundColor: userStyle.backgroundColor != "" ?
            userStyle.backgroundColor : themeStyle.backgroundColor

        progressColor: userStyle.progressColor != "" ?
            userStyle.progressColor : themeStyle.progressColor

        leftMargin: userStyle.leftMargin != undefined ?
            userStyle.leftMargin : themeStyle.leftMargin

        topMargin: userStyle.topMargin != undefined ?
            userStyle.topMargin : themeStyle.topMargin

        rightMargin: userStyle.rightMargin != undefined ?
            userStyle.rightMargin : themeStyle.rightMargin

        bottomMargin: userStyle.bottomMargin != undefined ?
            userStyle.bottomMargin : themeStyle.bottomMargin

        minimumWidth: userStyle.minimumWidth != undefined ?
            userStyle.minimumWidth : themeStyle.minimumWidth

        minimumHeight: userStyle.minimumHeight != undefined ?
            userStyle.minimumHeight : themeStyle.minimumHeight
    }

    property ProgressBarStyle themeStyle: ProgressBarStyle {
        progressColor: "blue"
        backgroundColor: "white"

        leftMargin: 0
        topMargin: 0
        rightMargin: 0
        bottomMargin: 0

        minimumWidth: 50
        minimumHeight: 50
    }
}
