import QtQuick 1.0
import "../templates"
import "../components" as Custom

Rectangle {
    SystemPalette{id:syspal}
    width: 4*256
    height: 620
    property int rowspacing: 24
    property int columnspacing: 14

    gradient: Gradient{
        GradientStop{ position:1 ; color:syspal.window}
        GradientStop{ position:0 ; color:Qt.darker(syspal.window, 1.2)}
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: parent.height*2
        Item {
            anchors.top:parent.top
            anchors.left:parent.left
            anchors.leftMargin:20
            anchors.rightMargin:20

            Row {
                anchors.fill: parent
                Item {
                    width:column1.width+2*rowspacing
                    height:column1.height+2*rowspacing
                    Column {
                        x: rowspacing
                        id: column1
                        spacing: columnspacing
                        anchors.top: parent.top
                        anchors.topMargin: 6

                        Text{ font.bold: true; text: "Default:" ; styleColor: "white" ; color: "#333" ; style: "Raised"}
                        Button {
                            id: btn
                            text: "Push Me"
                            Rectangle {
                                anchors.fill: parent
                                border.color: "#222"
                                color: btn.pressed ? "blue " : "red"
                                Text {
                                    anchors.centerIn: parent
                                    text: btn.text
                                }
                            }
                        }
                        ButtonRow {
                            Button{
                                id: btn2
                                text: "A"
                                Rectangle {
                                    anchors.fill: parent
                                    border.color: "#222"
                                    color: parent.parent.pressed ? "steelblue " : parent.parent.checked ? "blue" : "red"
                                    Text {
                                        anchors.centerIn: parent
                                        text: btn2.text
                                    }
                                }
                            }
                            Button{
                                id: btn3
                                text: "B"
                                Rectangle {
                                    anchors.fill: parent
                                    color: parent.parent.pressed ? "steelblue " : parent.parent.checked ? "blue" : "red"
                                    border.color: "#222"
                                    Text {
                                        anchors.centerIn: parent
                                        text: btn3.text
                                    }
                                }
                            }
                        }/*
                        TextField {
                            Rectangle{
                                anchors.fill:parent
                                radius: 2
                                border.color:"black"
                                color:"white"
                                anchors.bottomMargin:1
                                anchors.rightMargin:1
                            }
                        }

                        TextArea {
                            Rectangle {
                                anchors.fill: parent
                                radius: 2
                                border.color: "black"
                                color: "white"
                                anchors.bottomMargin: 1
                                anchors.rightMargin: 1
                            }
                            placeholderText: "This is a\n multiline control."
                        }
                        }*/
                        Slider {
                            value: 0.5
                            id: slider

                            height: 30

                            Rectangle {
                                id: groove
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                height: 10
                                color:  "red"
                                border { color: "black"; width: 1 }
                            }

                            handle: Rectangle {
                                width: 25
                                height: 25
                                anchors.verticalCenter: parent.verticalCenter
                                color:  "green"
                                border { color: "black"; width: 1 }

                                Item {
                                    visible: slider.pressed
                                    height: valueLabel.height + 5
                                    width: valueLabel.width + 5
                                    anchors.bottom: parent.top
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.margins: 5

                                    Rectangle {
                                        anchors.fill: parent
                                        color: "black"
                                        opacity: 0.75
                                        radius: 5
                                    }

                                    Text {
                                        id: valueLabel
                                        text: slider.formatValue(slider.value)
                                        anchors.centerIn: parent
                                        color: "white"
                                    }
                                }
                            }
                        }
                        Row {
                            spacing: rowspacing
                            anchors.horizontalCenter: parent.horizontalCenter
                            Switch {
                                id: sw2
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 2
                                    border.color: "black"
                                    color: "white"
                                    anchors.bottomMargin: 1
                                    anchors.rightMargin: 1
                                }
                                handle: Rectangle {
                                    width: sw2.height
                                    height: sw2.height
                                    border.color: "black"
                                    color: "red"
                                }

                            }
                            Switch {
                                id: sw
                                checked: true

                                Rectangle{
                                    anchors.fill: parent
                                    radius: 2
                                    border.color: "black"
                                    color: "white"
                                    anchors.bottomMargin:1
                                    anchors.rightMargin:1
                                }
                                handle: Rectangle {
                                    width: sw.height
                                    height: sw.height
                                    border.color:"black"
                                    color: "red"
                                }
                            }
                        }
                        Row{
                            CheckBox {
                                id: cb1
                                Rectangle{
                                    anchors.fill: parent
                                    radius: 2
                                    border.color: "black"
                                    color: "white"
                                    anchors.bottomMargin: 1
                                    anchors.rightMargin: 1
                                    Rectangle {
                                        width: 12
                                        height: 12
                                        visible: cb1.checked
                                        anchors.centerIn: parent
                                        radius: 5
                                        color: "black"
                                        smooth: true
                                    }
                                }
                            }
                            CheckBox {
                                id: cb2
                                checked: true
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 2
                                    border.color: "black"
                                    color:" white"
                                    anchors.bottomMargin: 1
                                    anchors.rightMargin: 1
                                    Rectangle {
                                        width: 12
                                        height: 12
                                        visible: cb2.checked
                                        anchors.centerIn: parent
                                        radius: 5
                                        color: "black"
                                        smooth: true
                                    }
                                }
                            }
                            RadioButton {
                                id: rb1
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 2
                                    border.color: "black"
                                    color: "white"
                                    anchors.bottomMargin: 1
                                    anchors.rightMargin: 1
                                    Rectangle {
                                        width:12
                                        height:12
                                        visible: rb1.checked
                                        anchors.centerIn: parent
                                        radius: 5
                                        color: "black"
                                        smooth: true
                                    }
                                }
                            }
                            RadioButton {
                                id: rb2
                                checked:true
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 2
                                    border.color: "black"
                                    color: "white"
                                    anchors.bottomMargin: 1
                                    anchors.rightMargin: 1
                                    Rectangle {
                                        width:12
                                        height:12
                                        visible: rb2.checked
                                        anchors.centerIn: parent
                                        radius: 5
                                        color: "black"
                                        smooth: true
                                    }
                                }
                            }
                            spacing: rowspacing
                        }
                        ProgressBar {
                            id: progress
                            Timer {
                                running: true
                                repeat: true
                                interval: 25
                                onTriggered: {
                                    var next = progress.value + 0.01;
                                    progress.value = (next > progress.maximumValue) ? progress.minimumValue : next;
                                }
                            }
                            Rectangle {
                                radius: 2
                                anchors.fill: parent
                                border.color: "black"
                                color: "white"
                                anchors.bottomMargin: 1
                                anchors.rightMargin: 1
                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: progress.value * progress.width
                                    radius: 2
                                    color: "green"
                                    smooth: true
                                }
                            }

                        }
                        ProgressBar {
                            indeterminate: true
                            Rectangle {
                                radius: 2
                                anchors.fill: parent
                                border.color: "black"
                                color: "white"
                                anchors.bottomMargin: 1
                                anchors.rightMargin: 1
                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: progress * parent.width
                                    radius: 5
                                    color: "black"
                                    smooth: true
                                }
                            }
                        }/*
                        Row {
                            spacing: rowspacing
                            anchors.horizontalCenter: parent.horizontalCenter
                            BusyIndicator { running: true }
                            BusyIndicator { running: false }
                        }*/
                    }
               }
               Item {
                    width:column2.width+2*rowspacing
                    height:column2.height+2*rowspacing
                    Column {
                        x: rowspacing
                        id: column2
                        spacing: columnspacing
                        anchors.top: parent.top
                        anchors.topMargin: 6

                        Text{ font.bold: true; text: "Custom:" ; styleColor: "white" ; color: "#333" ; style: "Raised"}
                        Custom.Button { text: "Push Me" }
                        Custom.ButtonRow {
                            Custom.Button { text: "A" }
                            Custom.Button { text: "B" }
                        }
                        Custom.Slider {
                            value: 0.5
                        }
                        Custom.Switch {}
                        Row {
                            spacing: rowspacing
                            Custom.CheckBox { }
                            Custom.CheckBox { checked: true }
                            Custom.RadioButton { }
                            Custom.RadioButton { checked: true }
                        }
                        Row {
                            spacing: rowspacing
                            anchors.horizontalCenter: parent.horizontalCenter
                            Custom.BusyIndicator { running: true }
                            Custom.BusyIndicator { running: false }
                        }
                        Custom.ProgressBar {
                            id: progress2
                            Timer {
                                running: true
                                repeat: true
                                interval: 25
                                onTriggered: {
                                    var next = progress2.value + 0.01;
                                    progress2.value = (next > progress2.maximumValue) ? progress2.minimumValue : next;
                                }
                            }
                        }
                        Custom.ProgressBar { indeterminate: true }
                    }
                }
            }
        }
    }
    /*
    ScrollDecorator {
        flickableItem: flickable
    }*/
}
