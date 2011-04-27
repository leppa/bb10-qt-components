import QtQuick 1.1
import "../components"
import "../components/styles/default"

Button {
    id: button

    implicitWidth: loader.item.implicitWidth

//    Rectangle {
//        anchors.fill: parent
//        border.color: "#222"
//        color: btn.pressed ? "blue " : "red"

//        Text {
//            id: _text
//            anchors.centerIn: parent
//            text: btn.text
//        }
//    }

    ButtonStyle {
        id: style
    }

    Loader {
        id: loader
        sourceComponent: style.background
        anchors.fill: parent
        property alias text:button.text
        property alias iconSource:button.iconSource
        property alias styledItem: button
        property alias position: button.__position
    }

}
