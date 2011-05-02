import QtQuick 1.1

Item {
    id: palette

    property string colorGroup: "active"

    property color text: loader.item.group.text
    property color base: loader.item.group.base
    property color window: loader.item.group.window
    property color windowText: loader.item.group.windowText
    property color highlight: loader.item.group.highlight
    property color highlightedText: loader.item.group.highlightedText

    Loader {
        id: loader
        property alias colorGroup: palette.colorGroup
        source: Qt.resolvedUrl(theme.path + "experimental/ThemePalette.qml")
    }
}
