import QtQuick 1.1
import "./private"
import "./styles" 1.0

Item {
    id: scrollDecorator
    anchors.fill: parent

    property Flickable flickableItem

    property alias delegate: loader.delegate
    property ScrollDecoratorStyle style: ScrollDecoratorStyle {}

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: scrollDecorator
        property alias userStyle: scrollDecorator.style
        filepath: Qt.resolvedUrl(theme.path + "ScrollDecorator.qml")
    }
}
