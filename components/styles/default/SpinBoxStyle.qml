import QtQuick 1.1

QtObject {
    property int minimumWidth: 200
    property int minimumHeight: 25

    property int leftMargin: 8
    property int topMargin: 8
    property int rightMargin: 8
    property int bottomMargin: 8

    property Component background: Component {
        Item {
            opacity: enabled ? 1 : 0.7
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                color: backgroundColor
                radius: 5
            }
            BorderImage {
                anchors.fill: parent
                id: backgroundimage
                smooth: true
                source: "images/lineedit_normal.png"
                border.left: 6; border.top: 6
                border.right: 50; border.bottom: 6
            }
        }
    }

    property Component up: Component {
        Item {
            anchors.right: parent.right
            anchors.top: parent.top
            width: 24
            height: parent.height/2
            Image {
                anchors.left: parent.left;
                anchors.top: parent.top;
                anchors.topMargin: 7
                opacity: (upEnabled && enabled) ? (upPressed ? 1 : 0.8) : 0.3
                source: "images/spinbox_up.png"
            }
        }
    }

    property Component down: Component {
        Item {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: 24
            height: parent.height/2
            Image {
                anchors.left: parent.left;
                anchors.bottom: parent.bottom;
                anchors.bottomMargin: 7
                opacity: (downEnabled && enabled) ? (downPressed ? 1 : 0.8) : 0.3
                source: "images/spinbox_down.png"
            }
        }
    }

    property Component hints: Component {
        Item {
            property int fontPixelSize: 14
            property bool fontBold: false
        }
    }
}
