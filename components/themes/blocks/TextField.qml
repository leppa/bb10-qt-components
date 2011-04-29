import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.TextField {
    id: textField

    themeStyle {
        textColor: "black"
        backgroundColor: "silver"
        leftMargin: 10
        topMargin: 5
        rightMargin: 10
        bottomMargin: 4
        minimumWidth: 150
        minimumHeight: 30
    }

    opacity: enabled ? 1.0 : 0.7

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        border.width: 1
        color: style.backgroundColor
    }

    Text {
        id: placeholder
        anchors {
            fill: parent
            leftMargin: textField.style.leftMargin
            topMargin: textField.style.topMargin
            rightMargin: textField.style.rightMargin
            bottomMargin: textField.style.bottomMargin
        }
        font: textInput.font
        text: widget.placeholderText
        opacity: !textInput.text.length && !textInput.activeFocus ? 0.7 : 0
    }
}
