import QtQuick 1.1
import "./private"
import "./styles" 1.0
import "./behaviors" 1.0    // TextEditMouseBehavior

// KNOWN ISSUES
// 1) TextArea does not loose focus when !enabled if it is a FocusScope (see QTBUG-16161)
// 2) Make sure the cursor is hidded and revealed as the text loses and gains focus

FocusScope {
    id: textArea

    property alias text: textEdit.text
    property alias font: textEdit.font

    property string placeholderText
    property alias activeFocus: textEdit.activeFocus
    property alias readOnly: textEdit.readOnly
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
    property alias zoomable: mouseEditBehavior.zoomable // enable pinch/double-click zoom by user
    property alias zoomFactor: mouseEditBehavior.zoomFactor

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
        var rect = textEdit.positionToRectangle(charPos);
        var mappedPos = mapFromItem(textEdit, rect.x, rect.y);
        rect.x = mappedPos.x; rect.y = mappedPos.y;
        return rect;
    }

    property alias delegate: loader.delegate
    property TextAreaStyle style: TextAreaStyle { }

    property Flickable flickHandler: flickable

    // Implementation

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight

    clip: true
    property alias desktopBehavior: mouseEditBehavior.desktopBehavior

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: textArea
        property alias textEdit: textEdit
        property alias userStyle: textArea.style
        filepath: Qt.resolvedUrl(theme.path + "TextArea.qml")
    }

    Flickable { //mm is FocusScope, so TextArea's root doesn't need to be, no?
        id: flickable
        clip: true
        property QtObject innerStyle: loader.item.style

        anchors {
            fill: parent
            leftMargin: innerStyle.leftMargin
            topMargin: innerStyle.topMargin
            rightMargin: innerStyle.rightMargin
            bottomMargin: innerStyle.bottomMargin
        }
        contentHeight: textEdit.implicitHeight
        interactive: (flickable == flickHandler)

        function ensureVisible(textEditor, cursorRect) {
            if (!flickHandler)
                return

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

            width: flickable.width / scale
            color: enabled ? flickable.innerStyle.textColor :
                Qt.tint(flickable.innerStyle.textColor, "#80ffffff")

            font.pixelSize: flickable.innerStyle.fontPixelSize
            font.bold: flickable.innerStyle.fontBold

            persistentSelection: false
            wrapMode: desktopBehavior ? TextEdit.NoWrap : TextEdit.Wrap
            onCursorRectangleChanged: flickable.ensureVisible(textEdit, cursorRectangle)

            transformOrigin: Item.TopLeft
            scale: mouseEditBehavior.zoomFactor
            Behavior on scale { NumberAnimation { duration: 100 } }

            onActiveFocusChanged: {
                if (textEdit.activeFocus)
                    textEdit.openSoftwareInputPanel();
                else
                    textEdit.closeSoftwareInputPanel();
            }
        }

        TextEditMouseBehavior { // Has to be inside the Flickable to work correctly with it
            id: mouseEditBehavior
            textEdit: textEdit
            desktopBehavior: false
            flickable: flickHandler
            width: textEdit.width * textEdit.scale
            height: textEdit.height * textEdit.scale
        }
    }

    MouseArea { // Make sure TextArea is focused even when clicking on its margins
        anchors.fill: parent
        onPressed: {
            textArea.forceActiveFocus();
            mouse.accepted = false;
        }
    }
}
