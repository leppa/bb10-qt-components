import QtQuick 1.1
import "./styles"       // TextFieldStylingProperties
import "./styles/default" as DefaultStyles
import "./behaviors"    // TextEditMouseBehavior

// KNOWN ISSUES
// 1) TextField does not loose focus when !enabled if it is a FocusScope (see QTBUG-16161)

FocusScope {
    id: textField

    property alias text: textInput.text
    property alias font: textInput.font

    property alias activeFocus: textInput.activeFocus
    property alias readOnly: textInput.readOnly
    property alias placeholderText: placeholderTextComponent.text
    property bool  passwordMode: false
    property alias cursorPosition: textInput.cursorPosition
    property alias selectedText: textInput.selectedText
    property alias selectionEnd: textInput.selectionEnd
    property alias selectionStart: textInput.selectionStart
    property alias canPaste: textInput.canPaste
    property alias inputMask: textInput.inputMask
    property alias echoMode: textInput.echoMode
    property alias validator: textInput.validator
    property alias acceptableInput: textInput.acceptableInput // true if text passed the validator. read-only
    property alias horizontalAlignment: textInput.horizontalAlignment
    property alias inputMethodHints: textInput.inputMethodHints
    property alias containsMouse: mouseArea.containsMouse

    function forceActiveFocus() { textInput.forceActiveFocus() }
    function cut() { textInput.cut() }
    function copy() { textInput.copy() }
    function paste() { textInput.paste() }
    function select(start, end) { textInput.select(start, end) }
    function selectAll() { textInput.selectAll() }
    function selectWord() { textInput.selectWord() }
    function deselect() { textInput.deselect() }
    function positionAt(x) {
        var p = mapToItem(textInput, x, 0);
        return textInput.positionAt(p.x);
    }

    function positionToRectangle(charPos) {
        var rect = textInput.positionToRectangle(charPos);
        var mappedPos = mapFromItem(textInput, rect.x, rect.y);
        rect.x = mappedPos.x; rect.y = mappedPos.y;
        return rect;
    }

    property TextFieldStylingProperties styling: TextFieldStylingProperties {
        textColor: syspal.text

        background: defaultStyle.background
        hints: defaultStyle.hints

        leftMargin: defaultStyle.leftMargin
        topMargin: defaultStyle.topMargin
        rightMargin: defaultStyle.rightMargin
        bottomMargin: defaultStyle.bottomMargin

        minimumWidth: defaultStyle.minimumWidth
        minimumHeight: defaultStyle.minimumHeight
    }

    // Implementation

    implicitWidth: Math.max(styling.minimumWidth, textInput.implicitWidth + styling.horizontalMargins())
    implicitHeight: Math.max(styling.minimumHeight, textInput.implicitHeight + styling.verticalMargins())

    property alias _hints: hintsLoader.item
    clip: true

    Loader { id: hintsLoader; sourceComponent: styling.hints }
    Loader {
        anchors.fill: parent
        property alias styledItem: textField
        sourceComponent: styling.background
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    TextInput { // see QTBUG-14936
        id: textInput
        font.pixelSize: _hints.fontPixelSize
        font.bold: _hints.fontBold

        anchors.leftMargin: styling.leftMargin
        anchors.topMargin: styling.topMargin
        anchors.rightMargin: styling.rightMargin
        anchors.bottomMargin: styling.bottomMargin

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        opacity: activeFocus ? 1 : 0
        color: enabled ? styling.textColor : Qt.tint(styling.textColor, "#80ffffff")
        echoMode: passwordMode ? _hints.passwordEchoMode : TextInput.Normal

        onActiveFocusChanged: {
            state = (activeFocus ? "focused" : "");

            if (activeFocus)
                openSoftwareInputPanel();
            else
                closeSoftwareInputPanel();
        }

        states: [
            State {
                name: ""
                PropertyChanges { target: textInput; cursorPosition: 0 }
            },
            State {
                name: "focused"
                PropertyChanges { target: textInput; cursorPosition: textInput.text.length }
            }
        ]

        transitions: Transition {
            to: "focused"
            SequentialAnimation {
                ScriptAction { script: textInput.cursorVisible = false; }
                ScriptAction { script: textInput.cursorPosition = textInput.positionAt(textInput.width); }
                NumberAnimation { target: textInput; property: "cursorPosition"; duration: 150 }
                ScriptAction { script: textInput.cursorVisible = true; }
            }
        }
    }

    Text {
        id: placeholderTextComponent
        anchors.fill: textInput
        font: textInput.font
        opacity: !textInput.text.length && !textInput.activeFocus ? 1 : 0
        color: "gray"
        text: "Enter text"
        Behavior on opacity { NumberAnimation { duration: 90 } }
    }

    DefaultStyles.TextFieldStyle { id: defaultStyle }
}
