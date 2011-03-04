import QtQuick 1.1
import "./styles/default" as DefaultStyles
import "./behaviors"    // TextEditMouseBehavior

// KNOWN ISSUES
// 1) TextArea does not loose focus when !enabled if it is a FocusScope (see QTBUG-16161)
// 2) Make sure the cursor is hidded and revealed as the text loses and gains focus

FocusScope {
    id: textArea

    property alias text: textEdit.text
    property alias font: textEdit.font

    property alias activeFocus: textEdit.activeFocus
    property alias readOnly: textEdit.readOnly
    property alias placeholderText: placeholderTextComponent.text
    property alias cursorPosition: textEdit.cursorPosition
    property alias selectedText: textEdit.selectedText
    property alias selectionEnd: textEdit.selectionEnd
    property alias selectionStart: textEdit.selectionStart
    property alias canPaste: textEdit.canPaste
    property alias horizontalAlignment: textEdit.horizontalAlignment
    property alias verticalAlignment: textEdit.verticalAlignment
    property alias wrapMode: textEdit.wrapMode  //mm Missing from spec
    property alias textFormat: textEdit.textFormat
    property alias inputMethodHints: textEdit.inputMethodHints
    property alias containsMouse: mouseEditBehavior.containsMouse

    function forceActiveFocus() { textEdit.forceActiveFocus() }
    function cut() { textEdit.cut() }
    function copy() { textEdit.copy() }
    function paste() { textEdit.paste() }
    function select(start, end) { textEdit.select(start, end) }
    function selectAll() { textEdit.selectAll() }
    function selectWord() { textEdit.selectWord() }
    function deselect() { textEdit.deselect() }

    function positionAt(x, y) {
        var p = mapToItem(textEdit, x, y);
        return textEdit.positionAt(p.x, p.y);
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

    property Flickable flickHandler: flickable

    // Implementation

    implicitWidth: Math.max(minimumWidth,
                    Math.max(textEdit.implicitWidth,
                             placeholderTextComponent.implicitWidth) + leftMargin + rightMargin)
    implicitHeight: Math.max(minimumHeight,
                     Math.max(textEdit.implicitHeight,
                              placeholderTextComponent.implicitHeight) + topMargin + bottomMargin)

    property alias desktopBehavior: mouseEditBehavior.desktopBehavior
    property alias _hints: hintsLoader.item
    clip: true

    Loader { id: hintsLoader; sourceComponent: hints }
    Loader {
        anchors.fill: parent
        property alias styledItem: textArea
        sourceComponent: background
    }


    Flickable { //mm is FocusScope, so TextArea's root doesn't need to be, no?
        id: flickable
        clip: true

        anchors.fill: parent
        anchors.leftMargin: leftMargin
        anchors.topMargin: topMargin
        anchors.rightMargin: rightMargin
        anchors.bottomMargin: bottomMargin
        contentHeight: textEdit.implicitHeight

        function ensureVisible(textEditor, cursorRect) {
            var cursorPosMappedToFlickHandler = textEditor.mapToItem(flickHandler, cursorRect.x, cursorRect.y);

            if(cursorPosMappedToFlickHandler.x < 0) {
                flickHandler.contentX -= -cursorPosMappedToFlickHandler.x;
            } else if(cursorPosMappedToFlickHandler.x+cursorRect.width >= flickHandler.width) {
                flickHandler.contentX  += cursorPosMappedToFlickHandler.x+cursorRect.width-flickHandler.width;
            }

            if(cursorPosMappedToFlickHandler.y < 0) {
                flickHandler.contentY -= -cursorPosMappedToFlickHandler.y;
            } else if(cursorPosMappedToFlickHandler.y+cursorRect.height >= flickHandler.height) {
                flickHandler.contentY += cursorPosMappedToFlickHandler.y+cursorRect.height-flickHandler.height;
            }
        }

        TextEdit { // see QTBUG-14936
            id: textEdit
            font.pixelSize: _hints.fontPixelSize
            font.bold: _hints.fontBold

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            color: enabled ? textColor: Qt.tint(textColor, "#80ffffff")
            wrapMode: desktopBehavior ? TextEdit.NoWrap : TextEdit.Wrap
            onCursorRectangleChanged: flickable.ensureVisible(textEdit, cursorRectangle)

            onActiveFocusChanged: activeFocus ? openSoftwareInputPanel() : closeSoftwareInputPanel()
        }

        TextEditMouseBehavior { // Has to be inside the Flickable to work correctly with it
            id: mouseEditBehavior
            anchors.fill: parent
            textEdit: textEdit
            desktopBehavior: false
            flickable: flickHandler
            copyPasteButtons: ButtonBlock {
                opacity: 0  // initially hidden
                Behavior on opacity { NumberAnimation { duration: 100 } }
            }
        }
    }

    MouseArea { // Make sure TextArea is focused even when clicking on its margins
        anchors.fill: parent
        onPressed: {
            textArea.forceActiveFocus();
            mouse.accepted = false;
        }
    }

    Text {
        id: placeholderTextComponent
        x: leftMargin; y: topMargin
        font: textEdit.font
        opacity: !textEdit.text.length && !textEdit.activeFocus ? 1 : 0
        color: "gray"
        clip: true
        text: "Enter text"  //mm Needs localization
        Behavior on opacity { NumberAnimation { duration: 90 } }
    }

    DefaultStyles.TextFieldStyle { id: defaultStyle }
    SystemPalette { id: syspal }
}

