import QtQuick 1.1
import "./styles"       // SpinBoxStylingProperties
import "./styles/default" as DefaultStyles
FocusScope {
    id: spinbox

    property real value: 0.0
    property real maximumValue: 99
    property real minimumValue: 0
    property real singleStep: 1
    property string postfix


    function increment() {
        setValue(textInput.text);
        value += singleStep;
        if (value > maximumValue)
            value = maximumValue;
        textInput.text = value;
    }

    function decrement() {
        setValue(textInput.text)
        value -= singleStep;
        if (value < minimumValue)
            value = minimumValue;
        textInput.text = value;
    }

    function setValue(value) {
        var newval = parseFloat(value);
        if (newval > maximumValue)
            newval = maximumValue;
        else if (value < minimumValue)
            newval = minimumValue;
        value = newval;
        textInput.text = value;
    }

    property alias upPressed: mouseUp.pressed
    property alias downPressed: mouseDown.pressed
    property alias upHovered: mouseUp.containsMouse
    property alias downHovered: mouseDown.containsMouse
    property alias containsMouse: mouseArea.containsMouse
    property alias font: textInput.font

    property bool upEnabled: (value < maximumValue)      // read-only
    property bool downEnabled: (value > minimumValue)    // read-only

    property SpinBoxStylingProperties styling: SpinBoxStylingProperties {
        backgroundColor: syspal.base
        textColor: syspal.text
        background: defaultStyle.background
        up: defaultStyle.up
        down: defaultStyle.down

        minimumWidth: defaultStyle.minimumWidth
        minimumHeight: defaultStyle.minimumHeight

        leftMargin: defaultStyle.leftMargin
        topMargin: defaultStyle.topMargin
        rightMargin: defaultStyle.rightMargin
        bottomMargin: defaultStyle.bottomMargin
    }

    QtObject {
        id: componentPrivate
        property bool valueUpdate: false
    }

    implicitWidth: Math.max(styling.minimumWidth, textInput.implicitWidth + styling.horizontalMargins())
    implicitHeight: Math.max(styling.minimumHeight, textInput.implicitHeight + styling.verticalMargins())
    Component.onCompleted: setValue(value)

    onValueChanged: {
        componentPrivate.valueUpdate = true
        textInput.text = value
        componentPrivate.valueUpdate = false
    }

    Loader {
        id: hintsLoader
        sourceComponent: defaultStyle.hints
    }

    // background
    Loader {
        id: backgroundComponent
        anchors.fill: parent
        sourceComponent: styling.background
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    TextInput {
        id: textInput
        anchors.fill: parent
        anchors.leftMargin: styling.leftMargin
        anchors.topMargin: styling.topMargin
        anchors.rightMargin: styling.rightMargin
        anchors.bottomMargin: styling.bottomMargin
        focus: true
        selectByMouse: true

        text: spinBox.value
        font.pixelSize: hintsLoader.item ? hintsLoader.item.fontPixelSize : 12
        font.bold: hintsLoader.item ? hintsLoader.item.fontBold : false
        validator: DoubleValidator { bottom: 11; top: 31 }
        onTextChanged: spinbox.setValue(text)
        onAccepted: {spinbox.setValue(textInput.text)}
        onActiveFocusChanged: spinbox.setValue(textInput.text)
        color: styling.textColor
        opacity: parent.enabled ? 1 : 0.5
        Text {
            text: postfix
            anchors.rightMargin: 4
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Loader {
        id: upButton
        property alias pressed : spinbox.upPressed
        property alias hover : spinbox.upHovered
        property alias enabled : spinbox.upEnabled
        sourceComponent: styling.up
        MouseArea {
            id: mouseUp
            anchors.fill: upButton.item
            onClicked: increment()

            property bool autoincrement: false
            onReleased: autoincrement = false
            Timer { running: mouseUp.pressed; interval: 350 ; onTriggered: mouseUp.autoincrement = true }
            Timer { running: mouseUp.autoincrement; interval: 60 ; repeat: true ; onTriggered: increment() }
        }
        onLoaded: {
            item.parent = spinbox;
            mouseUp.parent = item;
        }
    }

    Loader {
        id: downButton
        property alias pressed : spinbox.downPressed
        property alias hover : spinbox.downHovered
        property alias enabled : spinbox.downEnabled
        sourceComponent: styling.down
        MouseArea {
            id: mouseDown
            anchors.fill: downButton.item
            onClicked: decrement()

            property bool autoincrement: false
            onReleased: autoincrement = false
            Timer { running: mouseDown.pressed; interval: 350 ; onTriggered: mouseDown.autoincrement = true }
            Timer { running: mouseDown.autoincrement; interval: 60 ; repeat: true ; onTriggered: decrement() }
        }
        onLoaded: {
            item.parent = spinbox;
            mouseDown.parent = item;
        }
    }
    Keys.onUpPressed: increment()
    Keys.onDownPressed: decrement()
    DefaultStyles.SpinBoxStyle { id: defaultStyle }
    SystemPalette { id: syspal }
}
