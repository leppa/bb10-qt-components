import QtQuick 1.1
import QtLabs.components 1.0
import QtLabs.components.themes.template 1.0 as Template

Item {
    width: 1000
    height: 550

    property string position
    property int rowspacing: 22
    property int columnspacing: 14

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: parent.height * 2

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
                        x:rowspacing
                        id:column1
                        spacing: columnspacing
                        anchors.top:parent.top
                        anchors.topMargin:6

                        Text{ font.bold: true; text: "Default:" ; styleColor: "white" ; color: "#333" ; style: "Raised"}
                        Button { text:"Push me" }
                        ButtonRow {
                            Button{ text: "A" }
                            Button{ text: "B" }
                        }
                        TextField { }
                        TextArea { placeholderText: "This is a\n multiline control."}
                        Slider { value: 0.5 }
                        Row{
                            spacing:rowspacing
                            anchors.horizontalCenter:parent.horizontalCenter
                            Switch { }
                            Switch { checked: true }
                        }
                        Row{
                            CheckBox { } CheckBox { checked:true}
                            RadioButton{ } RadioButton { checked:true}
                            spacing: rowspacing
                        }
                        ProgressBar {
                            Timer {
                                running: true
                                repeat: true
                                interval: 25
                                onTriggered: {
                                    var next = parent.value + 0.01;
                                    parent.value = (next > parent.maximumValue) ? parent.minimumValue : next;
                                }
                            }
                        }
                        ProgressBar { indeterminate:true }
                        Row{
                            spacing:rowspacing
                            anchors.horizontalCenter:parent.horizontalCenter
                            BusyIndicator { running: true }
                            BusyIndicator { running: false }
                        }
                    }
                }
                Item {
                    width:column2.width+2*rowspacing
                    height:column2.height+2*rowspacing
                    Column {
                        x:rowspacing
                        id:column2
                        spacing: columnspacing
                        anchors.top:parent.top
                        anchors.topMargin:6

                        Column {
                            enabled:false
                            spacing: columnspacing
                            anchors.topMargin:6
                            Text{ font.bold:true; text:"Disabled:" ; styleColor: "white" ; color:"#333" ; style:"Raised"}
                            Button { text:"Push me"}
                            ButtonRow {
                                Button{ text: "A" }
                                Button{ text: "B" }
                            }
                            TextField { }
                            TextArea { placeholderText:"This is a\n multiline control."}
                            Slider { value: 0.5 }
                            Row{
                                spacing:rowspacing
                                anchors.horizontalCenter:parent.horizontalCenter
                                Switch { }
                                Switch { checked: true }
                            }
                            Row{
                                CheckBox { } CheckBox { checked:true}
                                RadioButton{ } RadioButton { checked:true}
                                spacing:rowspacing
                            }
                            ProgressBar {
                                Timer {
                                    running: true
                                    repeat: true
                                    interval: 25
                                    onTriggered: {
                                        var next = parent.value + 0.01;
                                        parent.value = (next > parent.maximumValue) ? parent.minimumValue : next;
                                    }
                                }
                            }
                            ProgressBar { indeterminate:true }
                            Row {
                                spacing: rowspacing
                                anchors.horizontalCenter: parent.horizontalCenter
                                BusyIndicator { running: true }
                                BusyIndicator { running: false }
                            }
                        }
                    }
                }

                Rectangle{
                    width:column3.width+2*rowspacing
                    height:column3.height+2*rowspacing
                    color:"#666"
                    border.color:"#444"
                    Column {
                        x:rowspacing
                        id:column3
                        spacing: columnspacing
                        anchors.top:parent.top
                        anchors.topMargin:6
                        property color bg: "#444"
                        property color fg: "#eee"
                        property color pg: "#f70"

                        Text{ font.bold:true; text:"Colored:" ; styleColor: "#333" ; color:"white" ; style:"Raised"}
                        Button { text:"Push me" ; style.backgroundColor: column3.bg; style.textColor: column3.fg}
                        ButtonRow {
                            Button{ text: "A" ; style.backgroundColor: column3.bg}
                            Button{ text: "B" ; style.backgroundColor: column3.bg}
                        }
                        TextField { style.backgroundColor: column3.bg; style.textColor: column3.fg}
                        TextArea  { placeholderText:"This is a\n multiline control."; style.backgroundColor: column3.bg; style.textColor: column3.fg}
                        Slider { value: 0.5; style.backgroundColor: column3.bg; style.progressColor: column3.pg;}
                        Row{
                            spacing:rowspacing
                            anchors.horizontalCenter:parent.horizontalCenter
                            Switch { style { switchColor: column3.bg; backgroundColor: column3.bg; positiveHighlightColor:column3.pg }}
                            Switch { style { switchColor: column3.bg; backgroundColor: column3.bg; positiveHighlightColor:column3.pg;} checked: true }
                        }
                        Row{
                            CheckBox { style { backgroundColor: checked ? column3.pg : column3.bg; ColorAnimation on backgroundColor {} }}
                            CheckBox { checked: true; style.backgroundColor: checked ? column3.pg : column3.bg; ColorAnimation on style.backgroundColor {}}
                            RadioButton{ style.backgroundColor: checked ? column3.pg : column3.bg; ColorAnimation on style.backgroundColor {}}
                            RadioButton { checked: true; style.backgroundColor: checked ? column3.pg : column3.bg; ColorAnimation on style.backgroundColor {} }
                            spacing:rowspacing
                        }
                        ProgressBar {
                            style.backgroundColor: column3.bg;
                            style.progressColor: column3.pg
                            Timer {
                                running: true
                                repeat: true
                                interval: 25
                                onTriggered: {
                                    var next = parent.value + 0.01;
                                    parent.value = (next > parent.maximumValue) ? parent.minimumValue : next;
                                }
                            }
                        }
                        ProgressBar{ indeterminate:true; style { backgroundColor: column3.bg; progressColor: column3.pg }}
                        Row{
                            spacing:rowspacing
                            anchors.horizontalCenter:parent.horizontalCenter
                            BusyIndicator { running: true }
                            BusyIndicator { running: false }
                        }
                    }
                }
                Rectangle{
                    width:column3.width+2*rowspacing
                    height:column3.height+2*rowspacing
                    color:"#ccc"
                    border.color:"#444"
                    Column {
                        x:rowspacing
                        id:column4
                        spacing: columnspacing
                        anchors.top:parent.top
                        anchors.topMargin:6

                        Text{ font.bold:true; text:"Custom:" ; styleColor: "white" ; color:"#333" ; style:"Raised"}
                        Button { text:"Push me" ; delegate: buttonDelegate; }
                        ButtonRow {
                            Button { text: "A" ; delegate: buttonDelegate; }
                            Button{ text: "B" ; delegate: buttonDelegate; }
                        }
                        TextField { delegate: textFieldDelegate; }
                        TextArea {  placeholderText:"This is a\n multiline control.";
                                    delegate: textAreaDelegate; }
                        Slider {
                            value: 0.5
                            height: 20
                            style.pinWidth: 20
                            delegate: sliderDelegate
                        }
                        Row{
                            spacing: rowspacing
                            Switch {
                                delegate: switchDelegate
                            }
                            Switch {
                                checked: true
                                delegate: switchDelegate
                            }
                        }
                        Row {
                            spacing: rowspacing
                            CheckBox { delegate: checkboxDelegate }
                            CheckBox { checked: true; delegate: checkboxDelegate}
                            RadioButton { delegate: radioDelegate; }
                            RadioButton { checked: true; delegate: radioDelegate; }
                        }
                        ProgressBar {
                            Timer {
                                running: true
                                repeat: true
                                interval: 25
                                onTriggered: {
                                    var next = parent.value + 0.01;
                                    parent.value = (next > parent.maximumValue) ? parent.minimumValue : next;
                                }
                            }
                            delegate: progressBarDelegate
                        }
                        ProgressBar {
                            indeterminate: true
                            delegate: progressBarDelegate
                        }
                        Row{
                            spacing:rowspacing
                            anchors.horizontalCenter: parent.horizontalCenter
                            BusyIndicator { delegate: busyDelegate; running: true }
                            BusyIndicator { delegate: busyDelegate; running: false }
                        }
                    }
                }
            }

            Component{
                id: busyDelegate

                Template.BusyIndicator {
                    implicitWidth: 40
                    implicitHeight: 40
                    BorderImage {
                        anchors.fill: parent
                        source: "customtheme/exampletheme/images/button_normal.png"
                        border.top:4 ; border.left:4 ; border.bottom:4 ; border.right:4

                        PropertyAnimation on rotation {
                            loops: Animation.Infinite
                            running: widget.running
                            from: 1; to: 360; duration: 500
                        }
                    }
                }
            }

            Component {
                id: textFieldDelegate

                Template.TextField {
                    themeStyle.leftMargin: 10
                    themeStyle.topMargin: 10
                    themeStyle.rightMargin: 10
                    themeStyle.bottomMargin: 10
                    themeStyle.minimumWidth: 90
                    themeStyle.minimumHeight: 32

                    BorderImage {
                        anchors.fill: parent
                        source: "customtheme/exampletheme/images/edit_normal.png"
                        border.left: 6; border.top: 6
                        border.right: 6; border.bottom: 6
                    }
                }
            }

            Component {
                id: textAreaDelegate

                Template.TextArea {
                    themeStyle.leftMargin: 10
                    themeStyle.topMargin: 10
                    themeStyle.rightMargin: 10
                    themeStyle.bottomMargin: 10
                    themeStyle.minimumWidth: 200
                    themeStyle.minimumHeight: 80

                    BorderImage {
                        anchors.fill: parent
                        border.left: 6; border.top: 6
                        border.right: 6; border.bottom: 6
                        source: "customtheme/exampletheme/images/edit_normal.png"
                    }
                }
            }

            Component{
                id: progressBarDelegate

                Template.ProgressBar {
                    themeStyle.minimumWidth: 200
                    themeStyle.minimumHeight: 16

                    BorderImage {
                        anchors.fill: parent
                        border.left: 6; border.top: 6
                        border.right: 6; border.bottom: 6
                        source: "customtheme/exampletheme/images/edit_normal.png"
                    }
                    BorderImage {
                        source: "customtheme/exampletheme/images/button_normal.png"
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        border.left: 6; border.top: 6
                        border.right: 6; border.bottom: 6
                        width: Math.round((widget.width - style.leftMargin - style.rightMargin) * complete)
                    }
                }
            }

            Component{
                id: buttonDelegate

                Template.Button {
                    clip:true
                    themeStyle.minimumWidth: 60
                    themeStyle.minimumHeight: 32
                    implicitWidth: Math.max(label.implicitWidth + 10,
                                            style.minimumWidth)
                    BorderImage {
                        x: position == "rightmost" ? -2 : 0
                        width: parent.width + (position == "leftmost" ? 5 : 0)
                        height: parent.height
                        source: widget.pressed ? "customtheme/exampletheme/images/button_pressed.png":
                            "customtheme/exampletheme/images/button_normal.png"
                        border.left: 6; border.top: 6
                        border.right: 6; border.bottom: 6
                        Text {
                            id: label
                            text: widget.text
                            anchors.centerIn: parent
                        }
                    }
                }
            }

            Component {
                id: radioDelegate

                Template.RadioButton {
                    themeStyle.minimumWidth: 32
                    themeStyle.minimumHeight: 32
                    BorderImage {
                        anchors.fill: parent
                        border.left: 6; border.top: 6
                        border.right: 6; border.bottom: 6
                        source: "customtheme/exampletheme/images/radiobutton_normal.png"
                        Image {
                            anchors.centerIn: parent
                            opacity: !enabled || widget.pressed ? 0.7 : 1
                            visible: widget.checked || widget.pressed ? 1 : 0
                            source: "customtheme/exampletheme/images/radiobutton_check.png"
                        }
                    }
                }
            }

            Component {
                id: checkboxDelegate

                Template.CheckBox {
                    themeStyle.minimumWidth: 32
                    themeStyle.minimumHeight: 32
                    BorderImage {
                        id: base
                        anchors.fill: parent
                        border.left: 6; border.top: 6
                        border.right: 6; border.bottom: 6
                        source: "customtheme/exampletheme/images/edit_normal.png"
                        Image {
                            anchors.centerIn: parent
                            opacity: !enabled || widget.pressed ? 0.7 : 1
                            visible: widget.checked || widget.pressed ? 1 : 0
                            source: "customtheme/exampletheme/images/checkbox_check.png"
                        }
                    }
                }
            }

            Component {
                id: sliderDelegate

                Template.Slider {
                    themeStyle.minimumWidth: 200
                    themeStyle.minimumHeight: 8
                    handle: BorderImage{
                        source: "customtheme/exampletheme/images/button_normal.png";
                        width: 30; height: 30
                        border { left:7; right: 7; top:7; bottom:7 }
                    }
                    groove: BorderImage {
                        source: "customtheme/exampletheme/images/edit_normal.png"
                        width: parent.width;
                        height: 8; smooth:true
                        border.left: 4; border.right: 4
                        border.top:4; border.bottom:4
                    }
                    valueIndicator: Item { }
                }
            }

            Component {
                id: switchDelegate

                Template.Switch {
                    handle: itemHandle
                    themeStyle.backgroundColor: "gray"
                    themeStyle.minimumWidth: 80
                    themeStyle.minimumHeight: itemHandle.height
                    Rectangle {
                        clip: true
                        anchors.fill: parent
                        color: style.backgroundColor
                        BorderImage {
                            id: itemHandle
                            width: 40
                            height: 40
                            source: widget.pressed ? "customtheme/exampletheme/images/button_pressed.png":"customtheme/exampletheme/images/button_normal.png"
                            border.left: 6; border.top: 6
                            border.right: 6; border.bottom: 6
                        }
                    }
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}
