import QtQuick 1.1
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
    property alias validator: textInput.validator
    property alias acceptableInput: textInput.acceptableInput // true if text passed the validator. read-only
    property alias horizontalAlignment: textInput.horizontalAlignment
    property alias inputMethodHints: textInput.inputMethodHints
    property alias containsMouse: mouseEditBehavior.containsMouse

    function forceActiveFocus() { textEdit.forceActiveFocus() }
    function cut() { textInput.cut() }
    function copy() { textInput.copy() }
    function paste() { textInput.paste() }
    function select(start, end) { textInput.select(start, end) }
    function selectAll() { textInput.selectAll() }
    function selectWord() { textInput.selectWord() }
    function deselect() { textEdit.deselect() }
    function positionAt(x) {
        var p = mapToItem(textInput, x, 0);
        return textInput.positionAt(p.x);
    }

    function positionToRectangle(charPos) {
        var rect = textInput.positionToRectangle(charPos);
        var mappedPos = mapFromItem(textInput, rect.x, rext.y);
        rect.x = mappedPos.x; rect.y = mappedPos.y;
        return rect;
    }

    property color textColor: syspal.text
    property color backgroundColor: syspal.base

    property Component background: defaultStyle.background
    property Component hints: defaultStyle.hints

    property int leftMargin: defaultStyle.leftMargin
    property int topMargin: defaultStyle.topMargin
    property int rightMargin: defaultStyle.rightMargin
    property int bottomMargin: defaultStyle.bottomMargin

    property int minimumWidth: defaultStyle.minimumWidth
    property int minimumHeight: defaultStyle.minimumHeight

    // Implementation

    implicitWidth: Math.max(minimumWidth,
                    textInput.implicitWidth + leftMargin + rightMargin)

    implicitHeight: Math.max(minimumHeight,
                     textInput.implicitHeight + topMargin + bottomMargin)

    property alias desktopBehavior: mouseEditBehavior.desktopBehavior
    property alias _hints: hintsLoader.item
    clip: true

    Loader { id: hintsLoader; sourceComponent: hints }
    Loader {
        anchors.fill: parent
        property alias styledItem: textField
        sourceComponent: background
    }

    TextInput { // see QTBUG-14936
        id: textInput
        font.pixelSize: _hints.fontPixelSize
        font.bold: _hints.fontBold

        anchors.leftMargin: leftMargin
        anchors.topMargin: topMargin
        anchors.rightMargin: rightMargin
        anchors.bottomMargin: bottomMargin

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        opacity: desktopBehavior || activeFocus ? 1 : 0
        color: enabled ? textColor : Qt.tint(textColor, "#80ffffff")
        echoMode: passwordMode ? _hints.passwordEchoMode : TextInput.Normal

        onActiveFocusChanged: {
            if (!desktopBehavior)
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
        text: "Enter text"  //mm Needs localization
        Behavior on opacity { NumberAnimation { duration: 90 } }
    }

    Text {
        id: unfocusedText
        anchors.fill: textInput
        clip: true
        font: textInput.font
        opacity: !desktopBehavior && !passwordMode && textInput.text.length && !textInput.activeFocus ? 1 : 0
        color: textInput.color
        elide: Text.ElideRight
        text: textInput.text
    }


    TextEditMouseBehavior {
        id: mouseEditBehavior
        anchors.fill: parent
        textInput: textInput
        desktopBehavior: false
        copyPasteButtons: ButtonBlock {
            opacity: 0  // initially hidden
            Behavior on opacity { NumberAnimation { duration: 100 } }
        }
    }

    DefaultStyles.TextFieldStyle { id: defaultStyle }
    SystemPalette { id: syspal }
}















