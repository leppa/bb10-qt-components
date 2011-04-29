import QtQuick 1.1
import QtLabs.components.styles 1.0

Item {
    id: template

    implicitWidth: Math.max(style.minimumWidth,
                            textInput.implicitWidth + style.leftMargin + style.rightMargin)
    implicitHeight: Math.max(style.minimumHeight,
                             textInput.implicitHeight + style.topMargin + style.bottomMargin)

    property TextFieldStyle style: TextFieldStyle {
        // colors
        textColor: userStyle.textColor != "" ?
            userStyle.textColor : themeStyle.textColor
        backgroundColor: userStyle.backgroundColor != "" ?
            userStyle.backgroundColor : themeStyle.backgroundColor

        // font
        fontPixelSize: userStyle.fontPixelSize != undefined ?
            userStyle.fontPixelSize : themeStyle.fontPixelSize
        fontBold: userStyle.fontBold != undefined ?
            userStyle.fontBold : themeStyle.fontBold

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

    property TextFieldStyle themeStyle: TextFieldStyle {
        fontPixelSize: 16
        fontBold: false
        leftMargin: 0; topMargin: 0;
        rightMargin: 0; bottomMargin: 0;
        minimumWidth: 0; minimumHeight: 0
    }
}
