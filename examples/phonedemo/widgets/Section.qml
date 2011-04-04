import QtQuick 1.1

Item {
    id: section
    property string title

    default property alias content: sectionContent.children

    anchors.left: parent.left
    anchors.right: parent.right

    height: sectionContent.height + 50

    BorderImage {
        id: topBorder
        border.top: 14
        border.left: 16
        border.right: 16
        source: "../images/section_up.png"
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40

        Text {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 6
            anchors.leftMargin: 10

            font.family: "Nokia Sans"
            font.pixelSize: 22
            color: "#3a4043"
            text: section.title
        }
    }

    Column {
        id: sectionContent
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: topBorder.height

        onChildrenChanged: {
            var items = sectionContent.children;
            var count = items.length;

            for (var i = 0; i < count; i++) {
                items[i].middle = (i != count - 1);
            }
        }
    }
}
