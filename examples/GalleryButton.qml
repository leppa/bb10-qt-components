import QtQuick 1.1
import "../templates"

Button {
    id: button

    property Rectangle __borderRect: borderRect

    Rectangle {
        id: borderRect
        anchors.fill: parent
        border.color: "#222"
        color: button.pressed ? "steelblue " : button.checked ? "grey" :"lightgrey"
        Text {
            anchors.centerIn: parent
            text: button.text
        }
    }
}
