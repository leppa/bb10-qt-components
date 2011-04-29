import QtQuick 1.1
import "./private"
import "./styles" 1.0
import "./behaviors" 1.0 // TextEditMouseBehavior

// KNOWN ISSUES
// 1) TextField does not loose focus when !enabled if it is a FocusScope (see QTBUG-16161)

FocusScope {
    id: textField

    property alias text: textInput.text
    property alias font: textInput.font

    property alias activeFocus: textInput.activeFocus
    property alias readOnly: textInput.readOnly
    property string placeholderText
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
    property alias containsMouse: mouseEditBehavior.containsMouse

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

    property alias delegate: loader.delegate
    property TextFieldStyle style: TextFieldStyle {}

    // Implementation

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight

    clip: true
    property alias desktopBehavior: mouseEditBehavior.desktopBehavior

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: textField
        property alias textInput: textInput
        property alias userStyle: textField.style
        filepath: Qt.resolvedUrl(theme.path + "TextField.qml")
    }

    TextInput { // see QTBUG-14936
        id: textInput
        property QtObject innerStyle: loader.item.style

        anchors {
            fill: parent
            leftMargin: innerStyle.leftMargin
            topMargin: innerStyle.topMargin
            rightMargin: innerStyle.rightMargin
            bottomMargin: innerStyle.bottomMargin
        }
        font {
            pixelSize: innerStyle.fontPixelSize
            bold: innerStyle.fontBold
        }
        //echoMode: passwordMode ? _hints.passwordEchoMode : TextInput.Normal

        onActiveFocusChanged: {
            if (textInput.activeFocus)
                textInput.openSoftwareInputPanel();
            else
                textInput.closeSoftwareInputPanel();
        }
    }

    TextEditMouseBehavior {
        id: mouseEditBehavior
        anchors.fill: parent
        textInput: textInput
        desktopBehavior: false
    }
}
