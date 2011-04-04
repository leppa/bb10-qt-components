import QtQuick 1.1
import "../widgets"
import "../../../components"

Page {
    id: photoPage
    title: "Photo Gallery"

    property bool isBusy: false

    PhotoModel {
        id: photoModel
    }

    GridView {
        id: grid
        visible: !photoPage.isBusy

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: bottomBar.top
        anchors.leftMargin: 2
        anchors.rightMargin: 2

        cellWidth: 116
        cellHeight: 120

        delegate: Item {
            width: 120
            height: 120

            Rectangle {
                color: "#444444"
                anchors.fill: img
                anchors.leftMargin: -2
                anchors.rightMargin: -2
                anchors.topMargin: -2
                anchors.bottomMargin: -2

                BorderImage {
                    source: "../images/shadow_album_art_small.png"
                    border.left: 20
                    border.right: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.bottom
                }
            }

            Image {
                id: img
                width: 110
                height: 110
                source: model.image
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    photoPage.next(Qt.resolvedUrl("PhotoZoomPage.qml"));
                    currentPage.imagePath = model.fullImage;
                }
            }
        }

        ScrollDecorator {
            flickableItem: grid
        }
    }

    BusyIndicator {
        running: photoPage.isBusy
        visible: photoPage.isBusy
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Timer {
        id: loadTimer
        interval: 1200
        running: false

        onTriggered: {
            if (recentButton.checked)
                grid.model = photoModel.recent;
            else if (favoriteButton.checked)
                grid.model = photoModel.favorite;
            else
                grid.model = photoModel.all;

            photoPage.isBusy = false;
        }
    }

    function startLoad() {
        photoPage.isBusy = true;
        loadTimer.start();
    }

    Rectangle {
        id: bottomBar
        height: 60
        color: "#111111"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Image {
            fillMode: Image.Tile
            source: "../images/shadow_top.png"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.top
        }

        ButtonRow {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                id: recentButton
                text: "Recent photos"
                onCheckedChanged: startLoad();
            }
            Button {
                id: favoriteButton
                text: "Favorite photos"
                onCheckedChanged: startLoad();
            }
            Button {
                id: allButton
                text: "All photos"
                onCheckedChanged: startLoad();
            }
        }
    }
}
