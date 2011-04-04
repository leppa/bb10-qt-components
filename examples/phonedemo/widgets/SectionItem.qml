import QtQuick 1.1

Item {
    id: sectionItem

    signal clicked()

    property bool middle: false
    property bool clickable: false
    property bool pressed: mouseArea.pressed

    default property alias content: sectionItemContent.children

    height: 46

    anchors.left: parent.left
    anchors.right: parent.right

    BorderImage {
        border.bottom: 14
        border.left: 16
        border.right: 16
        anchors.fill: parent
        source: mouseArea.pressed ?
            (middle ? "../images/section_mid_pressed.png"
               : "../images/section_down_pressed.png")
            : (middle ? "../images/section_mid.png"
               : "../images/section_down.png")
    }

    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#d7d7d7"
    }

    Item {
        id: sectionItemContent
        anchors.fill: parent
        anchors.margins: 10
    }

    MouseArea {
        id: mouseArea
        enabled: clickable
        anchors.fill: parent
        onClicked: sectionItem.clicked()
    }
}
