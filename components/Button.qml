import QtQuick 1.1
import "../templates"
import "./styles/default"

Button {
    id: button

    implicitWidth: loader.item.implicitWidth

    ButtonStyle {
        id: style
    }

    property string __position: "only"

    Loader {
        id: loader
        sourceComponent: style.background
        anchors.fill: parent
        property alias text: button.text
        property alias iconSource: button.iconSource
        property alias styledItem: button
        property alias position: button.__position
    }
}
