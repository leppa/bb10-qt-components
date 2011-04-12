import QtQuick 1.1
import "./styles"       // TextAreaStylingProperties
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

    property TextAreaStylingProperties styling: TextAreaStylingProperties {
        textColor: "black"

        background: defaultStyle.background
        hints: defaultStyle.hints

        leftMargin: defaultStyle.leftMargin
        topMargin: defaultStyle.topMargin
        rightMargin: defaultStyle.rightMargin
        bottomMargin: defaultStyle.bottomMargin

        minimumWidth: defaultStyle.minimumWidth
        minimumHeight: defaultStyle.minimumHeight
    }

    property Flickable flickHandler: flickable

    // Implementation

    implicitWidth: textEdit.scale * Math.max(styling.minimumWidth,
                    Math.max(textEdit.implicitWidth,
                             placeholderTextComponent.implicitWidth) + styling.horizontalMargins())
    implicitHeight: textEdit.scale * Math.max(styling.minimumHeight,
                     Math.max(textEdit.implicitHeight,
                              placeholderTextComponent.implicitHeight) + styling.verticalMargins())

    property alias desktopBehavior: mouseEditBehavior.desktopBehavior
    property alias _hints: hintsLoader.item
    clip: true

    Loader { id: hintsLoader; sourceComponent: styling.hints }
    Loader {
        anchors.fill: parent
        property alias styledItem: textArea
        sourceComponent: styling.background
    }


    Flickable { //mm is FocusScope, so TextArea's root doesn't need to be, no?
        id: flickable
        clip: true
        anchors.fill: parent
        anchors.leftMargin: styling.leftMargin
        anchors.topMargin: styling.topMargin
        anchors.rightMargin: styling.rightMargin
        anchors.bottomMargin: styling.bottomMargin

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

            font.pixelSize: _hints.fontPixelSize
            font.bold: _hints.fontBold
            width: flickable.width / scale

            persistentSelection: false
            color: enabled ? styling.textColor: Qt.tint(styling.textColor, "#80ffffff")
            wrapMode: desktopBehavior ? TextEdit.NoWrap : TextEdit.Wrap
            onCursorRectangleChanged: flickable.ensureVisible(textEdit, cursorRectangle)

            onActiveFocusChanged: activeFocus ? openSoftwareInputPanel() : closeSoftwareInputPanel()

            transformOrigin: Item.TopLeft
            scale: mouseEditBehavior.zoomFactor
            Behavior on scale { NumberAnimation { duration: 100 } }
        }

        TextEditMouseBehavior { // Has to be inside the Flickable to work correctly with it
            id: mouseEditBehavior
            width: textEdit.width*textEdit.scale
            height: textEdit.height*textEdit.scale
            textEdit: textEdit
            desktopBehavior: false
            flickable: flickHandler
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
        x: styling.leftMargin; y: styling.topMargin
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

