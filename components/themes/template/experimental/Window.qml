import QtQuick 1.1
import QtLabs.components.experimental.styles 1.0

Item {
    id: template

    implicitWidth: style.minimumWidth
    implicitHeight: style.minimumHeight

    property WindowStyle style: WindowStyle {
        // colors
        backgroundColor: userStyle.backgroundColor != "" ?
            userStyle.backgroundColor : themeStyle.backgroundColor

        // minimum size
        minimumWidth: userStyle.minimumWidth != undefined ?
            userStyle.minimumWidth : themeStyle.minimumWidth
        minimumHeight: userStyle.minimumHeight != undefined ?
            userStyle.minimumHeight : themeStyle.minimumHeight
    }

    property WindowStyle themeStyle: WindowStyle {
        backgroundColor: "white"
        minimumWidth: 200
        minimumHeight: 200
    }
}
