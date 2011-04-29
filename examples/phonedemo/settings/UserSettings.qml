import QtQuick 1.1
import "../widgets"
import "../../../components"

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
                title: "Basic Information"

                SectionItem {
                    Text {
                        text: "Username"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    TextField {
                        anchors.right: parent.right
                        placeholderText: "Enter your username"
                    }
                }
                SectionItem {
                    Text {
                        text: "Password"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    TextField {
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Fullname"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    TextField {
                        anchors.right: parent.right
                    }
                }
            }

            Section {
                title: "Description"

                SectionItem {
                    height: 200

                    TextArea {
                        anchors.fill: parent
                        placeholderText: "Enter a description"
                    }
                }
            }

            Section {
                title: "Social Network"

                SectionItem {
                    Text {
                        text: "Update twitter messages"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    Switch {
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Update orkut messages"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    Switch {
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Update facebook messages"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    Switch {
                        anchors.right: parent.right
                    }
                }
            }

            Section {
                title: "Offline message"

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
