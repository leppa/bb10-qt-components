import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.TextArea {
    id: textArea
    placeholder: placeholderItem

    themeStyle {
        textColor: "black"
        backgroundColor: "white"
        leftMargin: 10
        topMargin: 10
        rightMargin: 10
        bottomMargin: 10
        minimumWidth: 100
        minimumHeight: 200
        fontPixelSize: 16
        fontBold: false
    }

    Rectangle { // background
        anchors.fill: parent
        anchors.margins: 1
        radius: 5
        color: textArea.style.backgroundColor

        BorderImage {
            anchors.fill: parent
            smooth: true
            opacity: enabled ? 1.0 : 0.7
            source: "images/lineedit_normal.png"
            border { left: 6; top: 6; right: 6; bottom: 6; }
        }
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
        Behavior on opacity { NumberAnimation { duration: 90 } }
    }
}
