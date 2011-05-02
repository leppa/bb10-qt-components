import QtQuick 1.1
import "../widgets"
import "../../../components"
import "../../../components/experimental"

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
                anchors.left: parent.left
                anchors.right: parent.right

                SectionItem {
                    Text {
                        font.family: "Nokia Sans"
                        font.pixelSize: 20
                        color: activePalette.windowText
                        text: "Offline mode"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    Text {
                        text: "This will disable all connections"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    Switch {
                        checked: true
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
                        text: "Wi-Fi"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    Text {
                        text: "Turn on to choose a network..."
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
                        text: "Sounds"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    Text {
                        text: "Turn off to disable all Sounds"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    Switch {
                        checked: true
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Ringtone"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    Slider {
                        value: 0.8
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Downloaded"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    ProgressBar {
                        value: 0.7
                        //indeterminate: true
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
                        text: "Display"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    Text {
                        text: "Brightness"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    Slider {
                        value: 0.5
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Turn on display when charging"
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
                        text: "Email backup"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    Text {
                        text: "Online"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    RadioButton {
                        checked: true
                        anchors.right: parent.right
                    }
                }
                SectionItem {
                    Text {
                        text: "Backup emails each day"
                        color: activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
                    }
                    CheckBox {
                        checked: true
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
                        text: "More Options"
                        opacity: 0.9
                    }
                }
                SectionItem {
                    id: options1
                    clickable: true
                    Text {
                        text: "User settings"
                        color: options1.pressed ? activePalette.highlightedText
                            : activePalette.windowText
                        font.family: "Nokia Sans"
                        font.pixelSize: 17
                        opacity: 0.6
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
