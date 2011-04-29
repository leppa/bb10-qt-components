import QtQuick 1.1
import "../widgets"
import "../../../components"

Page {
    id: settings
    title: "Settings"

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
                title: "Offline mode"

                SectionItem {
                    Text {
                        text: "This will disable all connections"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    Switch {
                        checked: true
                        anchors.right: parent.right
                    }
                }
            }

            Section {
                title: "Wi-Fi"

                SectionItem {
                    Text {
                        text: "Turn on to choose a network..."
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
                title: "Sounds"

                SectionItem {
                    Text {
                        text: "Turn off to disable all Sounds"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    Switch {
                        checked: true
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Ringtone"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    Slider {
                        value: 0.8
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Downloaded"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    ProgressBar {
                        value: 0.7
                        //indeterminate: true
                        anchors.right: parent.right
                    }
                }

            }

            Section {
                title: "Display"

                SectionItem {
                    Text {
                        text: "Brightness"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    Slider {
                        value: 0.5
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Turn on display when charging"
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
                title: "Email backup"

                SectionItem {
                    Text {
                        text: "Online"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    RadioButton {
                        checked: true
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Backup emails each day"
                        color: "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    CheckBox {
                        checked: true
                        anchors.right: parent.right
                    }
                }
            }

            Section {
                title: "More Options"

                SectionItem {
                    id: options1
                    clickable: true
                    Text {
                        text: "User settings"
                        color: options1.pressed ? "white" : "#7a7f80"
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                    }
                    Image {
                        source: "../images/more.png"
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    onClicked: settings.next(Qt.resolvedUrl("UserSettings.qml"));
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}
