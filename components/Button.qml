import QtQuick 1.1
import "./private"
import "./styles" 1.0

BasicButton {
    id: button

    property string text
    property url iconSource

    property alias delegate: loader.delegate
    property ButtonStyle style: ButtonStyle { }

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: button
        property alias userStyle: button.style
        filepath: Qt.resolvedUrl(theme.path + "Button.qml")
    }

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight
}
