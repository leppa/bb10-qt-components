import QtQuick 1.1
import QtLabs.components.styles 1.0

Item {
    id: template
    property Item placeholder

    implicitWidth: textEdit.scale *
        Math.max(style.minimumWidth,
                 textEdit.implicitWidth + style.leftMargin + style.rightMargin)
    implicitHeight: textEdit.scale *
        Math.max(style.minimumHeight,
                 textEdit.implicitHeight + style.topMargin + style.bottomMargin)

    property TextAreaStyle style: TextAreaStyle {
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

    property TextAreaStyle themeStyle: TextAreaStyle {
        fontPixelSize: 16
        fontBold: false
        textColor: "black"
        leftMargin: 0; topMargin: 0;
        rightMargin: 0; bottomMargin: 0;
        minimumWidth: 0; minimumHeight: 0;
    }
}
