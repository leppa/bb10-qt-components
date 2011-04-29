import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.TextField {
    id: textField

    themeStyle {
        textColor: "black"
        backgroundColor: "white"
        leftMargin: 10
        topMargin: 5
        rightMargin: 4
        bottomMargin: 10
        minimumWidth: 150
        minimumHeight: 30
    }

    Rectangle { // background
        anchors.fill: parent
        anchors.margins: 1
        radius: 5
        color: style.backgroundColor

        BorderImage {
            anchors.fill: parent
            smooth: true
            opacity: enabled ? 1.0 : 0.7
            source: "images/lineedit_normal.png"
            border { left: 6; top: 6; right: 6; bottom: 6; }
        }
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
        Behavior on opacity { NumberAnimation { duration: 90 } }
    }
}
