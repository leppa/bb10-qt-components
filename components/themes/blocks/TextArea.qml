import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.TextArea {
    id: textArea
    placeholder: placeholderItem

    themeStyle {
        textColor: "black"
        backgroundColor: "silver"
        leftMargin: 10
        topMargin: 10
        rightMargin: 10
        bottomMargin: 10
        minimumWidth: 200
        minimumHeight: 80
        fontPixelSize: 16
        fontBold: false
    }

    opacity: enabled ? 1.0 : 0.7

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        border.width: 1
        color: style.backgroundColor
    }

    Text {
        id: placeholderItem
        anchors {
            fill: parent
            leftMargin: textArea.style.leftMargin
            topMargin: textArea.style.topMargin
            rightMargin: textArea.style.rightMargin
            bottomMargin: textArea.style.bottomMargin
        }
        font: textEdit.font
        color: textEdit.color
        text: widget.placeholderText
        opacity: !textEdit.text.length && !textEdit.activeFocus ? 0.7 : 0
    }
}
