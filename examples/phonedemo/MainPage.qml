import QtQuick 1.1
import "widgets"
import "../../components"

Page {
    id: main
    title: "Main Menu"

    menuDelegate: PageMenu {
        title: main.title
        backEnabled: false
    }

    ListModel {
        id: listModel

        ListElement { title: "Contacts"; source: "contact/ContactPage.qml"}
        ListElement { title: "Photo Gallery"; source: "photo/PhotoPage.qml"; }
        ListElement { title: "Phone Settings"; source: "settings/SettingsPage.qml"}
    }

    ListView {
        id: listView
        anchors.fill: parent

        model: listModel

        delegate: Rectangle {
            width: listView.width
            height: 52
            color: mouseArea.pressed ? "#cccccc" : "#ffffff"

            Text {
                anchors.fill: parent
                anchors.margins: 8
                font.family: "Nokia Sans"
                font.pixelSize: 22
                text: title
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: main.next(Qt.resolvedUrl(source));
            }

            Image {
                fillMode: Image.Tile
                source: "images/fulldivisor.png"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
        }
    }

    ScrollDecorator {
        flickableItem: listView
    }
}