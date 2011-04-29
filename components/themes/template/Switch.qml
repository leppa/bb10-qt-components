import QtQuick 1.1
import QtLabs.components.styles 1.0

Item {
    id: template
    property Item handle

    implicitWidth: style.minimumWidth
    implicitHeight: style.minimumHeight

    property SwitchStyle style: SwitchStyle {
        textColor: userStyle.textColor != "" ?
            userStyle.textColor : themeStyle.textColor

        switchColor: userStyle.switchColor != "" ?
            userStyle.switchColor : themeStyle.switchColor

        backgroundColor: userStyle.backgroundColor != "" ?
            userStyle.backgroundColor : themeStyle.backgroundColor

        negativeHighlightColor: userStyle.negativeHighlightColor != "" ?
            userStyle.negativeHighlightColor : themeStyle.negativeHighlightColor

        positiveHighlightColor: userStyle.positiveHighlightColor != "" ?
            userStyle.positiveHighlightColor : themeStyle.positiveHighlightColor

        minimumWidth: userStyle.minimumWidth != undefined ?
            userStyle.minimumWidth : themeStyle.minimumWidth

        minimumHeight: userStyle.minimumHeight != undefined ?
            userStyle.minimumHeight : themeStyle.minimumHeight

        animatedMove: userStyle.animatedMove != undefined ?
            userStyle.animatedMove : themeStyle.animatedMove
    }

    property SwitchStyle themeStyle: SwitchStyle {
        minimumWidth: 0
        minimumHeight: 0
        animatedMove: false
    }

    Component.onCompleted: {
        // XXX:
        if (template.handle) {
            if (style.animatedMove == true) {
                style.animatedMove = false;
                template.handle.x = handleCenterX - template.handle.width / 2;
                style.animatedMove = true;
            } else {
                template.handle.x = handleCenterX - template.handle.width / 2;
            }
        }
    }
}
