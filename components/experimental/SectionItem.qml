import QtQuick 1.1
import "../private"
import "styles" 1.0

Item {
    id: sectionItem

    signal clicked()

    property bool clickable: false
    property alias pressed: mouseArea.pressed

    default property alias content: sectionContent.children

    property string __position: ""

    anchors.left: parent.left
    anchors.right: parent.right

    property alias delegate: loader.delegate
    property SectionItemStyle style: SectionItemStyle {}

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: sectionItem
        property alias mouseArea: mouseArea
        property alias userStyle: sectionItem.style
        filepath: Qt.resolvedUrl(theme.path + "experimental/SectionItem.qml")
    }

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight

    Item {
        id: sectionContent
        anchors.fill: parent
        anchors.leftMargin: loader.item.style.leftMargin
        anchors.topMargin: loader.item.style.topMargin
        anchors.rightMargin: loader.item.style.rightMargin
        anchors.bottomMargin: loader.item.style.bottomMargin
    }

    MouseArea {
        id: mouseArea
        enabled: clickable
        anchors.fill: parent
        onClicked: sectionItem.clicked()
    }
}
