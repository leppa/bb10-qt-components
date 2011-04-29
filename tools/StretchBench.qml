import QtQuick 1.1
import "../components"
import "stretchbench"

Item {
    width: 950
    height: 500

    property string currentComponentName: componentsList.model.get(componentsList.currentIndex).component

    SystemPalette { id: syspal }
    Rectangle {
        id: listPanel
        color: "lightgray";
        width: 200
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        ListView {
            id: componentsList
            anchors.fill: parent

            model: ListModel {
                ListElement { component: "ButtonRow" }
                ListElement { component: "ButtonColumn" }
                ListElement { component: "Switch" }
                ListElement { component: "Button" }
                ListElement { component: "CheckBox" }
                ListElement { component: "RadioButton" }
                ListElement { component: "Slider" }
                ListElement { component: "ProgressBar" }
                ListElement { component: "BusyIndicator" }
                ListElement { component: "TextField" }
                ListElement { component: "TextArea" }
            }

            highlight: Rectangle { color: "blue" }
            delegate: Item {
                width: componentsList.width
                height: item.height
                Item { id: item
                    width: itemText.width+20; height: itemText.height+6
                    Text {
                        id: itemText; text: component; font.pixelSize: 20; anchors.centerIn: parent
                        color: index == ListView.view.currentIndex ? "white" : "black"
                    }
                }
                MouseArea { anchors.fill: parent; onPressed: componentsList.currentIndex = index }
            }
        }
    }

    Rectangle {
        anchors.fill: testBenchRect
        color: "lightblue"
    }

    Flickable {
        id: testBenchRect
        anchors.left: listPanel.right; anchors.right: testConfigPanel.left
        anchors.top: parent.top; anchors.bottom: parent.bottom
        contentWidth: width+1    // Add a little to make it flickable
        contentHeight: height+1
        clip: true

        Image {
            anchors.fill: parent
            anchors.margins: -1000
            source: "stretchbench/images/checkered.png"
            fillMode: Image.Tile
            opacity: testBenchRect.moving || topLeftHandle.pressed || bottomRightHandle.pressed ? 0.12 : 0
            Behavior on opacity { NumberAnimation { duration: 100 } }
        }

        // Upper-left resizing handle

        MouseArea {
            id: topLeftHandle
            width: 30
            height: 30

            drag.target: topLeftHandle
            drag.minimumX: 0; drag.minimumY: 0
            drag.maximumX: bottomRightHandle.x - width
            drag.maximumY: bottomRightHandle.y - height

            Rectangle {
                anchors.fill: parent
                color: "blue"
            }
        }

        // Container for the tested Component (red when resized)

        Rectangle {
            id: container

            property bool pressed: topLeftHandle.pressed || bottomRightHandle.pressed

            color: "transparent"
            border.color: pressed ? "red" : "transparent"

            function resetSize() {
                // Position the blue drag handles so that the component tested gets its desired size
                topLeftHandle.x = (testBenchRect.width - loader.item.implicitWidth) / 2 - topLeftHandle.width;
                topLeftHandle.y = (testBenchRect.height - loader.item.implicitHeight) / 2 - topLeftHandle.height;
                bottomRightHandle.x = (testBenchRect.width - loader.item.implicitWidth) / 2 + loader.item.implicitWidth;
                bottomRightHandle.y = (testBenchRect.height - loader.item.implicitHeight) / 2 + loader.item.implicitHeight;
            }

            // Use this instead of anchors (see QTBUG-15622);
            // Floor ensures that images are on integer coordinates so they stay crisp
            y: Math.floor(topLeftHandle.y + topLeftHandle.height)
            x: Math.floor(topLeftHandle.x + topLeftHandle.width)
            width: Math.floor(bottomRightHandle.x - topLeftHandle.x - topLeftHandle.width)
            height: Math.floor(bottomRightHandle.y - topLeftHandle.y - topLeftHandle.height)

            Loader {
                id: loader
                focus: true
                sourceComponent: sourceComponentFromIndex()
                anchors.fill: parent

                onStatusChanged: {
                    if (status == Loader.Ready) {
                        container.resetSize();

                        // on any future implicit size changes, reset the size
//                        item.implicitWidthChanged.connect(container.resetSize);
//                        item.implicitHeightChanged.connect(container.resetSize);
                    }
                }

                function sourceComponentFromIndex() {
                    var name = componentsList.model.get(componentsList.currentIndex).component;
                    switch (name) {
                    case "Button": return buttonComponent;
                    case "ButtonRow": return buttonRowComponent;
                    case "ButtonColumn": return buttonColumnComponent;
                    case "CheckBox": return checkBoxComponent;
                    case "RadioButton": return radioButtonComponent;
                    case "Switch": return switchComponent;
                    case "Slider": return sliderComponent;
                    case "ProgressBar": return progressBarComponent;
                    case "BusyIndicator": return busyIndicatorComponent;
                    case "TextField": return textFieldComponent;
                    case "TextArea": return textAreaComponent;
                    }
                    return null;
                }

                Rectangle {
                    id: marginsRect
                    color: "transparent"
                    opacity: container.pressed && loader.item.style && loader.item.style.topMargin != undefined ? 1 : 0
                    border.color: "yellow"
                    anchors.fill: parent
                    z: 2
                    Connections {
                        target: loader
                        onItemChanged: {
                            if(!loader.item || !loader.item.style) return;
                            marginsRect.anchors.leftMargin = Math.max(loader.item.style.leftMargin, 0);
                            marginsRect.anchors.rightMargin = Math.max(loader.item.style.rightMargin, 0);
                            marginsRect.anchors.topMargin = Math.max(loader.item.style.topMargin, 0);
                            marginsRect.anchors.bottomMargin = Math.max(loader.item.style.bottomMargin, 0);
                        }
                    }
                }
            }
        }

        // Lower-right resizing handle

        MouseArea {
            id: bottomRightHandle
            width: 30
            height: 30

            drag.target: bottomRightHandle
            drag.minimumX: topLeftHandle.x + width
            drag.minimumY: topLeftHandle.y + height
            drag.maximumX: testBenchRect.width - width;
            drag.maximumY: testBenchRect.height - height

            Rectangle {
                anchors.fill: parent
                color: "blue"
            }
        }
    }
    ScrollDecorator {
        flickableItem: testBenchRect
    }

    //
    // Right-hand side Component configuration panel
    //

    Rectangle {
        id: testConfigPanel
        color: "lightgray";
        width: 250
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "Button" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: buttonOptionDimmed }
            StretchBenchBoolOption { text: "Latching:"; id: buttonOptionLatching }
            StretchBenchBoolOption { text: "Has icon:"; id: buttonOptionHasIcon }
            StretchBenchBoolOption { text: "Two-line text:"; id: buttonOptionTwoLineText }
            StretchBenchBoolOption { text: "Green background:"; id: buttonOptionGreenBackground }
            StretchBenchBoolOption { text: "White text:"; id: buttonOptionWhiteText }
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "ButtonRow" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: buttonRowOptionDimmed }
            StretchBenchBoolOption { text: "Checkable:"; id: buttonRowOptionCheckable }
            StretchBenchBoolOption { text: "Exclusive selection:"; id: buttonRowOptionExclusiveSelection }
            StretchBenchBoolOption { text: "First button opacity = 0"; id: buttonRowOptionFirstButtonTransparent }
            StretchBenchBoolOption { text: "Last button !visible"; id: buttonRowOptionLastButtonNotVisible }
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "ButtonColumn" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: buttonColumnOptionDimmed }
            StretchBenchBoolOption { text: "Checkable:"; id: buttonColumnOptionCheckable }
            StretchBenchBoolOption { text: "Exclusive selection:"; id: buttonColumnOptionExclusiveSelection }
            StretchBenchBoolOption { text: "First button opacity = 0"; id: buttonColumnOptionFirstButtonTransparent }
            StretchBenchBoolOption { text: "Last button !visible"; id: buttonColumnOptionLastButtonNotVisible }
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "CheckBox" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: checkBoxOptionDimmed }
            StretchBenchBoolOption { text: "Green background:"; id: checkBoxOptionGreenBackground }
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "RadioButton" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: radioButtonOptionDimmed }
            StretchBenchBoolOption { text: "Green background:"; id: radioButtonOptionGreenBackground }
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "Switch" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: switchOptionDimmed }
            StretchBenchBoolOption { text: "Green positive highlight:"; id: switchOptionGreenPositiveHighlight }
            StretchBenchBoolOption { text: "Red negative highlight:"; id: switchOptionRedNegativeHighlight }
            StretchBenchBoolOption { text: "Blue switch color:"; id: switchOptionBlueSwitchColor}
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "Slider" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: sliderOptionDimmed }
            StretchBenchBoolOption { text: "Vertical"; id: sliderOptionVertical }
            StretchBenchBoolOption { text: "Inverted"; id: sliderOptionInverted }
            StretchBenchBoolOption { text: "Steps"; id: sliderOptionSteps }
            StretchBenchBoolOption { text: "Value at 30:"; id: sliderOptionValueAt30 }
            StretchBenchBoolOption { text: "Zero in middle:"; id: sliderOptionZeroInMiddle }
            StretchBenchBoolOption { text: "Time formatted:"; id: sliderOptionTimeFormatted }
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "BusyIndicator" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: busyIndicatorOptionDimmed }
            StretchBenchBoolOption { text: "Paused (i.e. !running):"; id: busyIndicatorOptionPaused }
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "TextField" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: textFieldOptionDimmed }
            StretchBenchBoolOption { text: "Red text color:"; id: textFieldOptionRedText; }
            StretchBenchBoolOption { text: "Italic font:"; id: textFieldOptionItalicText; }
            StretchBenchBoolOption { text: "Password mode:"; id: textFieldOptionPasswordMode; }
            StretchBenchBoolOption { text: "Focused:"; id: textFieldOptionFocused;
                onCheckedChanged: if(checked) loader.item.forceActiveFocus(); else secondTextField.focus = true; }
            StretchBenchBoolOption { text: "Read-only:"; id: textFieldOptionReadOnly; }

            TextField { id: secondTextField; placeholderText: "Click to verify focus handling"; width: 230}
            TextField { }
            TextField { }

            //mm doesn't quite seem to work
//            StretchBenchBoolOption { text: "Focused:"; checked: textField.activeFocus;
//                onCheckedChanged: { if(checked) textField.focus = false; else textField.forceActiveFocus(); }
//            }
//            TextField { id: textField }
        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "TextArea" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: textAreaOptionDimmed }
            StretchBenchBoolOption { text: "Red text color:"; id: textAreaOptionRedText; }
            StretchBenchBoolOption { text: "Italic font:"; id: textAreaOptionItalicText; }
            StretchBenchBoolOption { text: "Focused:"; id: textAreaOptionFocused;
                onCheckedChanged: if(checked) loader.item.forceActiveFocus(); else secondTextField2.focus = true; }
            StretchBenchBoolOption { text: "Read-only:"; id: textAreaOptionReadOnly; }

            TextField { id: secondTextField2; placeholderText: "Click to verify focus handling"; width: 230}
            TextField { }
            TextField { }

        }

        Column {
            anchors.fill: parent; anchors.margins: 10; spacing: 5
            opacity: currentComponentName == "ProgressBar" ? 1 : 0
            StretchBenchBoolOption { text: "Dimmed:"; id: progressBarOptionDimmed }
            StretchBenchBoolOption { text: "Indeterminate:"; id: progressBarOptionIndeterminate }
        }
    }

    //
    // The components that we use in the stretch bench
    //

    Component {
        id: buttonComponent
        Button {
            enabled: !buttonOptionDimmed.checked
            checkable: buttonOptionLatching.checked
            text: buttonOptionTwoLineText.checked ? "Button\nwith two lines" : "Button"
            iconSource: buttonOptionHasIcon.checked ? "stretchbench/images/testIcon.png" : ""
            style.backgroundColor: buttonOptionGreenBackground.checked ? "green" : "#fff"
            style.textColor: buttonOptionWhiteText.checked ? "white" : "black"
        }
    }

    Component {
        id: buttonRowComponent
        ButtonRow {
            Button { text: "Button A"; checkable: buttonRowOptionCheckable.checked
                opacity: buttonRowOptionFirstButtonTransparent.checked ? 0 : 1;
                Behavior on opacity { NumberAnimation { duration: 500 } }
            }
            Button { text: "Button B1"; checkable: buttonRowOptionCheckable.checked }
            Button { text: "Button C12"; checkable: buttonRowOptionCheckable.checked} //;iconSource: "images/testIcon.png" }
            Button { text: "Button D123"; checkable: buttonRowOptionCheckable.checked;
                visible: !buttonRowOptionLastButtonNotVisible.checked
            }
            enabled: !buttonRowOptionDimmed.checked
            exclusive: buttonRowOptionExclusiveSelection.checked
        }
    }
    Component {
        id: buttonColumnComponent
        ButtonColumn {
            Button { text: "Button A"; checkable: buttonColumnOptionCheckable.checked
                opacity: buttonColumnOptionFirstButtonTransparent.checked ? 0 : 1;
                Behavior on opacity { NumberAnimation { duration: 500 } }
            }
            Button { text: "Button B1"; checkable: buttonColumnOptionCheckable.checked }
            Button { text: "Button C12"; checkable: buttonColumnOptionCheckable.checked }
            Button { text: "Button D123"; checkable: buttonColumnOptionCheckable.checked
                visible: !buttonColumnOptionLastButtonNotVisible.checked
            }
            enabled: !buttonColumnOptionDimmed.checked
            exclusive: buttonColumnOptionExclusiveSelection.checked
        }
    }

    Component {
        id: checkBoxComponent
        CheckBox {
            enabled: !checkBoxOptionDimmed.checked
            style.backgroundColor: checkBoxOptionGreenBackground.checked ? "green" : "#fff"
        }
    }

    Component {
        id: radioButtonComponent
        RadioButton {
            enabled: !radioButtonOptionDimmed.checked
            style.backgroundColor: radioButtonOptionGreenBackground.checked ? "green" : "#fff"
        }
    }

    Component {
        id: sliderComponent
        Slider {
            enabled: !sliderOptionDimmed.checked
            value: sliderOptionValueAt30.checked ? 30 : 0
            minimumValue: sliderOptionZeroInMiddle.checked ? -50 : 0
            maximumValue: sliderOptionZeroInMiddle.checked ? 50 : 100

            orientation: sliderOptionVertical.checked ? Qt.Vertical : Qt.Horizontal
            stepSize: sliderOptionSteps.checked ? 5.0 : 1.0
            inverted: sliderOptionInverted.checked

            function formatValue(v) {
                v = Math.round(v);
                var absV = Math.abs(v);
                if (sliderOptionTimeFormatted.checked) {
                    var seconds = Math.floor(absV % 60);
                    var minutes = Math.floor(absV / 60);

                    if (seconds < 10) seconds = "0" + seconds;
                    return (v < 0 ? "-" : "") + minutes + ":" + seconds
                }
                return v;
            }
        }
    }

    Component {
        id: progressBarComponent
        ProgressBar {
            enabled: !progressBarOptionDimmed.checked
            indeterminate: progressBarOptionIndeterminate.checked
            Timer {
                id: timer
                running: true
                repeat: true
                interval: 25
                onTriggered: {
                    var next = parent.value + 0.01;
                    parent.value = (next > parent.maximumValue) ? parent.minimumValue : next;
                }
            }
        }
    }

    Component {
        id: busyIndicatorComponent
        BusyIndicator {
            enabled: !busyIndicatorOptionDimmed.checked
            running: !busyIndicatorOptionPaused.checked
        }
    }

    Component {
        id: textFieldComponent
        TextField {
            enabled: !textFieldOptionDimmed.checked
            style.textColor: textFieldOptionRedText.checked ? "red" : "black"
            font.italic: textFieldOptionItalicText.checked
            passwordMode: textFieldOptionPasswordMode.checked
            focus: textFieldOptionFocused.checked
            readOnly: textFieldOptionReadOnly.checked
        }
    }

    Component {
        id: textAreaComponent
        TextArea {
            enabled: !textAreaOptionDimmed.checked
            style.textColor: textAreaOptionRedText.checked ? "red" : "black"
            font.italic: textAreaOptionItalicText.checked
            focus: textAreaOptionFocused.checked
            readOnly: textAreaOptionReadOnly.checked
        }
    }

    Component {
        id: switchComponent
        Switch {
            enabled: !switchOptionDimmed.checked
            style.positiveHighlightColor: switchOptionGreenPositiveHighlight.checked ? "green" : syspal.highlight
            style.negativeHighlightColor: switchOptionRedNegativeHighlight.checked ? "red" : "transparent"
            style.switchColor: switchOptionBlueSwitchColor.checked ? "blue" : syspal.button
        }
    }
}
