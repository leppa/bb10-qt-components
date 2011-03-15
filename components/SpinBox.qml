import QtQuick 1.1
import "./styles/default" as DefaultStyles

Item {
    id: spinBox

    property real value: 0.0      // read-only. see setValue(), increment() and decrement()
    property real minimumValue: 0
    property real maximumValue: 100
    property real stepSize: 1

    function increment() {
        value += stepSize;
        if (value > maximumValue)
            value = maximumValue;
        textInput.text = value;
    }

    function decrement() {
        value -= stepSize;
        if (value < minimumValue)
            value = minimumValue;
        textInput.text = value;
    }

    function setValue(v) {
        var newval = parseFloat(v);
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
    property alias activeFocus: textInput.activeFocus
    property alias font: textInput.font

    property bool upEnabled: (value < maximumValue)      // read-only
    property bool downEnabled: (value > minimumValue)    // read-only

    property color backgroundColor: syspal.base
    property color textColor: syspal.text

    property Component background: defaultStyle.background
    property Component up: defaultStyle.up
    property Component down: defaultStyle.down

    property int minimumWidth: defaultStyle.minimumWidth
    property int minimumHeight: defaultStyle.minimumHeight

    property int leftMargin: defaultStyle.leftMargin
    property int topMargin: defaultStyle.topMargin
    property int rightMargin: defaultStyle.rightMargin
    property int bottomMargin: defaultStyle.bottomMargin

    // implementation

    implicitWidth: Math.max(minimumWidth, textInput.implicitWidth + leftMargin + rightMargin)
    implicitHeight: Math.max(minimumHeight, textInput.implicitHeight + topMargin + bottomMargin)

    Loader { // background
        anchors.fill: parent
        property alias styledItem: spinBox
        sourceComponent: background
    }

    Loader {
        id: hintsLoader
        sourceComponent: defaultStyle.hints
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    TextInput {
        id: textInput
        anchors.fill: parent
        anchors.leftMargin: leftMargin
        anchors.topMargin: topMargin
        anchors.rightMargin: rightMargin
        anchors.bottomMargin: bottomMargin
        focus: true
        selectByMouse: true
        text: spinBox.value
        font.pixelSize: hintsLoader.item ? hintsLoader.item.fontPixelSize : 12
        font.bold: hintsLoader.item ? hintsLoader.item.fontBold : false
        validator: DoubleValidator { bottom: 11; top: 31 }
        onTextChanged: spinBox.setValue(text)
        color: textColor
        opacity: parent.enabled ? 1 : 0.5
    }

    Loader {
        id: upButtonLoader
        property alias pressed: spinBox.upPressed
        property alias hover: spinBox.upHovered
        property alias enabled: spinBox.upEnabled
        property alias styledItem: spinBox
        sourceComponent: up
        MouseArea {
            id: mouseUp
            anchors.fill: upButtonLoader.item
            onClicked: increment()

            property bool autoIncrement: false
            onReleased: autoIncrement = false
            Timer { running: mouseUp.pressed; interval: 350; onTriggered: mouseUp.autoIncrement = true }
            Timer { running: mouseUp.autoIncrement; interval: 60; repeat: true; onTriggered: increment() }
        }
        onLoaded: {
            item.parent = spinBox;
            mouseUp.parent = item;
        }
    }

    Loader {
        id: downButtonLoader
        property alias pressed: spinBox.downPressed
        property alias hover: spinBox.downHovered
        property alias enabled: spinBox.downEnabled
        property alias styledItem: spinBox
        sourceComponent: down
        MouseArea {
            id: mouseDown
            anchors.fill: downButtonLoader.item
            onClicked: decrement()

            property bool autoIncrement: false
            onReleased: autoIncrement = false
            Timer { running: mouseDown.pressed; interval: 350; onTriggered: mouseDown.autoIncrement = true }
            Timer { running: mouseDown.autoIncrement; interval: 60; repeat: true; onTriggered: decrement() }
        }
        onLoaded: {
            item.parent = spinBox;
            mouseDown.parent = item;
        }
    }

    DefaultStyles.SpinBoxStyle { id: defaultStyle }
    SystemPalette { id: syspal }
}
