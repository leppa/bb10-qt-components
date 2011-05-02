import QtQuick 1.1
import "../widgets"
import "../../../components"

Page {
    id: contactPage
    title: "Contacts"

    ListView {
        id: listView
        anchors.fill: parent
        anchors.topMargin: board.height

        model: ContactModel { }

        delegate: Item {
            height: model.entry ? 94 : 56
            width: listView.width

            property color textColor: !area.pressed ? activePalette.windowText
                : activePalette.highlightedText

            Rectangle {
                anchors.fill: parent
                color: activePalette.highlight
                visible: area.pressed
            }

            Image {
                id: icon
                source: "../images/list_icon_chat.png"
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 8
                anchors.bottomMargin: 8
            }

            Text {
                text: name[0]
                color: textColor
                font.bold: true
                font.pixelSize: 28
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 4
                anchors.leftMargin: 12
                visible: model.entry
            }

            Text {
                text: name
                color: textColor
                font.bold: true
                font.pixelSize: 13
                anchors.top: icon.top
                anchors.left: icon.right
                anchors.topMargin: 0
                anchors.leftMargin: 4
            }

            Text {
                text: phone
                color: textColor
                font.pixelSize: 13
                anchors.top: icon.top
                anchors.left: icon.right
                anchors.topMargin: 18
                anchors.leftMargin: 4
            }

            Rectangle {
                height: 1
                color: "gray"
                opacity: 0.5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }

            MouseArea {
                id: area
                anchors.fill: parent
                onClicked: {
                    dialer.image = "";
                    contactPage.state = "dialing"
                }
            }
        }

        ScrollDecorator {
            flickableItem: listView
        }
    }

    Rectangle {
        id: board
        color: "#DDDDDD"
        height: 150
        anchors.left: parent.left
        anchors.right: parent.right

        Row {
            y: 8
            spacing: 12
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                delegate: Image {
                    source: "../images/contact/athila_small.png"
                }
                onClicked: {
                    dialer.image = "../images/contact/athila.png";
                    contactPage.state = "dialing";
                }
            }
            Button {
                delegate: Image {
                    source: "../images/contact/dani_small.png"
                }
                onClicked: {
                    dialer.image = "../images/contact/dani.png";
                    contactPage.state = "dialing";
                }
            }
            Button {
                delegate: Image {
                    source: "../images/contact/marcia_small.png"
                }
                onClicked: {
                    dialer.image = "../images/contact/marcia.png";
                    contactPage.state = "dialing";
                }
            }
        }

        TextField {
            anchors.left: parent.left
            anchors.right: searchButton.left
            anchors.bottom: parent.bottom
            anchors.margins: 6
        }

        Button {
            id: searchButton
            text: "Search"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 6
        }

        BorderImage {
            source: "../images/shadow_bottom.png"
            border.left: 20
            border.right: 20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.bottom
        }
    }

    Rectangle {
        id: overlay
        color: "black"
        opacity: 0.0
        anchors.fill: parent
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: contactPage.state = "";
        }
    }

    DialPopup {
        id: dialer
        height: 480
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        onEndCall: contactPage.state = "";
    }

    states: [
        State {
            name: "dialing"
            PropertyChanges { target: overlay; visible: true; opacity: 0.7 }
            PropertyChanges { target: dialer; visible: true; anchors.topMargin: -480; }
        }
    ]

    transitions: [
        Transition {
            to: "dialing"
            reversible: true
            PropertyAction { target: dialer; properties: "visible"; }
            PropertyAction { target: overlay; properties: "visible"; }
            ParallelAnimation {
                NumberAnimation { target: dialer; properties: "anchors.topMargin";
                                  easing.type: Easing.InOutQuart; duration: 600; }
                NumberAnimation { target: overlay; properties: "opacity"; duration: 600; }
            }
        }
    ]
}
