import QtQuick 1.1
import "../widgets"
import "../../../components"
import "../../../components/experimental"

Page {
    id: settings
    title: "User Settings"

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: content.height + 20

        Column {
            id: content
            y: 10
            spacing: 10
            anchors.margins: 10
            anchors.left: parent.left
            anchors.right: parent.right

            Section {
                anchors.left: parent.left
                anchors.right: parent.right

                SectionItem {
                    Text {
                        font.family: "Nokia Sans"
                        font.pixelSize: 20
                        color: activePalette.windowText
                        text: "Basic Information"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    Text {
                        text: "Username"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    TextField {
                        anchors.right: parent.right
                        placeholderText: "Enter your username"
                    }
                }
                SectionItem {
                    Text {
                        text: "Password"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    TextField {
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Fullname"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    TextField {
                        anchors.right: parent.right
                    }
                }
            }

            Section {
                anchors.left: parent.left
                anchors.right: parent.right

                SectionItem {
                    Text {
                        font.family: "Nokia Sans"
                        font.pixelSize: 20
                        color: activePalette.windowText
                        text: "Description"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    height: 200

                    TextArea {
                        anchors.fill: parent
                        placeholderText: "Enter a description"
                    }
                }
            }

            Section {
                anchors.left: parent.left
                anchors.right: parent.right

                SectionItem {
                    Text {
                        font.family: "Nokia Sans"
                        font.pixelSize: 20
                        color: activePalette.windowText
                        text: "Social Network"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    Text {
                        text: "Update twitter messages"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    Switch {
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Update orkut messages"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    Switch {
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Update facebook messages"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    Switch {
                        anchors.right: parent.right
                    }
                }
            }

            Section {
                anchors.left: parent.left
                anchors.right: parent.right

                SectionItem {
                    Text {
                        font.family: "Nokia Sans"
                        font.pixelSize: 20
                        color: activePalette.windowText
                        text: "Offline Message"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    height: 200

                    TextArea {
                        anchors.fill: parent
                    }
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}
