import QtQuick 1.0

QtObject {
    property int minimumWidth: 11
    property int minimumHeight: 40

    property Component content: Component {
        Item {
            Rectangle {
                anchors.fill: parent
                anchors.margins: 3
                color: "gray"
                border.color: "black"
                radius: 2
                opacity: 0.7
            }
        }
    }
}
