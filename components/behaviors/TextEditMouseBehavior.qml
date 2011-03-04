import QtQuick 1.1
import "../"

// KNOWN ISSUES
// 1) Can't tell if the Paste button should be shown or not, see QTBUG-16190
// 2) Hard to tell if the Select button should be shown (part of QTBUG-16190?)

Item {
    id: mouseBehavior

    property TextInput textInput
    property TextEdit textEdit
    property Flickable flickable
    property bool desktopBehavior: true
    property alias containsMouse: mouseArea.containsMouse

    property Component copyPasteButtons

    // Implementation

    property Item textEditor: Qt.isQtObject(textInput) ? textInput : textEdit

    Connections {
        target: textEditor
        onTextChanged: reset()
        onCursorPositionChanged: reset()
        onSelectedTextChanged: reset()
        onActiveFocusChanged: reset()
    }

    Connections {
        target: flickable
        onMovementEnded: reset() // will make the popup appear if needed
    }

    // Calling reset() will hide the copy/paste popup, then restart
    // its visiblilty timer if there is selected text
    function reset() {
        copyPastePopup.showing = false;
        copyPastePopup.showing = selectedText.length > 0 && !desktopBehavior;
        copyPastePopup.wasCancelledByClick = false;
        copyPastePopup.wasClosedByCopy = false;
    }

    Component.onCompleted: {
        // Make sure these properties are set the way we want
        textEditor.focus = true;
        textEditor.selectByMouse = false;
        textEditor.activeFocusOnPress = false;
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        property int pressedPos
        property int selectionStartAtPress
        property int selectionEndAtPress
        property bool hadFocusBeforePress
        property bool draggingStartHandle
        property bool draggingEndHandle

        function characterPositionAt(mouse) {
            var mappedMouse = mapToItem(textEditor, mouse.x, mouse.y);
            if(Qt.isQtObject(textInput)) {
                return textInput.positionAt(mappedMouse.x);
            } else {
                return textEdit.positionAt(mappedMouse.x, mappedMouse.y);
            }
        }

        onPressed: {
            hadFocusBeforePress = textEditor.activeFocus;
            selectionStartAtPress = textEditor.selectionStart;
            selectionEndAtPress = textEditor.selectionEnd;

            textEditor.forceActiveFocus();    //mm see QTBUG-16157
            var pos = characterPositionAt(mouse);
            if(desktopBehavior) {
                textEditor.cursorPosition = pos;
            } else {
                draggingStartHandle = false;    // reset both to false, i.e. no dragging of selection endpoints
                draggingEndHandle = false;
                if(textEditor.selectedText.length > 0) {
                    // start dragging the selection start/end if the user clicked within 3 characters from the
                    // current selection start/end, otherwise allow flickable to handle further mosue events
                    if(Math.abs(textEditor.selectionStart-pos) < 3 || Math.abs(textEditor.selectionEnd-pos) < 3) {
                        // if the press pos is beyond the center point between selection start and end points
                        // then we're dragging the end point, otherwise the start point. works with small selections too.
                        draggingEndHandle = (pos > selectionStartAtPress + (selectionEndAtPress-selectionStartAtPress)/2);
                        draggingStartHandle = !draggingEndHandle;
                        preventStealing = true; // prevent flicking
                    }
                }
            }

            // remember the character position that was pressed for later
            pressedPos = textEditor.cursorPosition;
        }

        onPressAndHold: {
            if(!desktopBehavior) {
                preventStealing = true; // prevent flicking
                if(textEditor.readOnly && !draggingStartHandle && !draggingStartHandle) {
                    textEditor.cursorPosition = characterPositionAt(mouse);
                    textEditor.selectWord(); // at cursor position
                } else if(!textEditor.selectedText.length) {
                    textEditor.cursorPosition = characterPositionAt(mouse);
                }
            }
        }

        onReleased: {
            if(!desktopBehavior) {
                preventStealing = false; // re-enable flicking
                if(mouse.wasHeld) copyPastePopup.showing = true;
            }
        }

        onClicked: {
            if(!desktopBehavior) {
                if(!hadFocusBeforePress || draggingStartHandle || draggingEndHandle)
                    return;

                var pos = characterPositionAt(mouse);
                if(textEditor.selectedText.length) { // clicked on or outside selection
                    if(copyPastePopup.wasClosedByCopy && pos >= textEditor.selectionStart && pos < textEditor.selectionEnd)
                        copyPastePopup.showing = true;
                    else
                        textEditor.deselect(); // clear selection
                } else {    // clicked while there's no selection
                    if(pos == textEditor.cursorPosition) {  // Clicked where the cursor already where
                        copyPastePopup.showing = !copyPastePopup.wasCancelledByClick;
                        copyPastePopup.wasCancelledByClick = false;
                    } else { // clicked in a new place (where the cursor wasn't)
                        var endOfWordPosition = pos;
                        if(textEditor.text[pos] != '\n') { // not clicked beyond a newline char?
                            // find the end of the workd (won't work with RtL scripts!)
                            var endOfWordRegEx = /[^\b]\b/g;
                            endOfWordRegEx.lastIndex = pos;
                            if(endOfWordRegEx.test(textEditor.text))   // updates lastIndex
                                endOfWordPosition = endOfWordRegEx.lastIndex;
                        }

                        if(textEditor.cursorPosition != endOfWordPosition) {
                            textEditor.cursorPosition = endOfWordPosition;
                        } else {
                            copyPastePopup.showing = !copyPastePopup.wasCancelledByClick;
                            copyPastePopup.wasCancelledByClick = false;
                        }
                    }
                }
            }

            textEditor.openSoftwareInputPanel()
        }

        onPositionChanged: {
            if(!pressed)
                return;

            var pos = characterPositionAt(mouse);
            if(desktopBehavior) {
                textEditor.select(pressedPos, pos);
            } else {
                if(draggingStartHandle) {
                    textEditor.select(selectionEndAtPress, pos);
                } else if(draggingEndHandle) {
                    textEditor.select(selectionStartAtPress, pos);
                } else if(mouse.wasHeld && textEditor.cursorPosition != pos) {  // there's no selection
                    textEditor.cursorPosition = pos;
                    if(textEditor.readOnly) {
                        textEditor.selectWord(); // at cursor position
                    }

                    copyPastePopup.showing = true; // show once not pressed any more
                }
            }
        }

        onDoubleClicked: {
            if(desktopBehavior)
                textEditor.selectAll();
            else {
                textEditor.cursorPosition = characterPositionAt(mouse);
                textEditor.selectWord(); // select word at cursor position
            }
        }
    }


    function selectionPopoutPoint() {
        var point = {x:0, y:0}

        var selectionStartRect = textEditor.positionToRectangle(textEditor.selectionStart);
        var mappedStartPoint = mapFromItem(textEditor, selectionStartRect.x, selectionStartRect.y);
        mappedStartPoint.x = Math.max(mappedStartPoint.x, 0);
        mappedStartPoint.y = Math.max(mappedStartPoint.y, 0);

        var selectioEndRect = textEditor.positionToRectangle(textEditor.selectionEnd);
        var mappedEndPoint = mapFromItem(textEditor, selectioEndRect.x, selectioEndRect.y);
        mappedEndPoint.x = Math.min(mappedEndPoint.x, textEditor.width);
        mappedEndPoint.y = Math.min(mappedEndPoint.y, textEditor.height);

        var multilineSelection = (selectionStartRect.y != selectioEndRect.y);
        if(!multilineSelection) {
            point.x = mappedStartPoint.x + (mappedEndPoint.x-mappedStartPoint.x)/2
            point.y = mappedStartPoint.y;
        } else {
            point.x = textEditor.x + textEdit.width/2;

            if(Qt.isQtObject(flickable)) {
                var mappedSelectionStartRectTopLeft = flickable.mapFromItem(textEditor, selectionStartRect.x, selectionStartRect.y);
                if(mappedSelectionStartRectTopLeft.y < 0) {
                    var mappedEditorPos = flickable.mapFromItem(textEditor, textEditor.x, textEditor.y);
                    point.y = -mappedEditorPos.y + flickable.height/2;
                } else {
                    point.y = mappedStartPoint.y;
                }
            } else {
                point.y = mappedStartPoint.y;
            }
        }

        return point;
    }

    Item {
        id: copyPastePopup
        Component {
            id: copyPasteButtons
            ButtonRow {
                opacity: 0
                exclusive: false
                property color bgcolor:"#444"

                Behavior on opacity { NumberAnimation { duration: 100 } }
                Button{
                    id: copyButton
                    text: "Copy"
                    visible: textEditor.selectedText.length > 0
                    backgroundColor: bgcolor
                    textColor: "white"
                    onClicked: {
                         textEditor.copy()
                         copyPastePopup.showing = false;
                         copyPastePopup.wasClosedByCopy = true;
                    }
                }
                Button {
                    id: cutButton
                    text: "Cut"
                    visible: textEditor.selectedText.length > 0 && !textEditor.readOnly
                    backgroundColor: bgcolor
                    textColor: "white"
                    onClicked: textEditor.cut()
                }
                Button {
                    id: pasteButton
                    text: "Paste"
                    visible: textEditor.canPaste
                    backgroundColor: bgcolor
                    textColor: "white"
                    onClicked: textEditor.paste()
                }
                Button {
                    id: selectButton
                    text: "Select"
                    visible: textEditor.text.length > 0 && textEditor.selectedText.length == 0
                    backgroundColor: bgcolor
                    textColor: "white"
                    onClicked: textEditor.selectWord()
                }
                Button {
                    id: selectAllButton
                    text: "Select all"
                    visible: textEditor.text.length > 0 && textEditor.selectedText.length == 0
                    backgroundColor: bgcolor
                    textColor: "white"
                    onClicked: textEditor.selectAll()
                }
            }
        }
        property alias showing: modalPopup.showing
        property bool wasCancelledByClick: false
        property bool wasClosedByCopy: false

        function positionPopout(popup, window) {   // position poput above the text field's cursor
            var popoutPoint = selectionPopoutPoint();
            var mappedPos = mapToItem(window, popoutPoint.x, popoutPoint.y);
            popup.x = Math.max(mappedPos.x - popup.width/2, 0);
            if(popup.x+popup.width > window.width)
                popup.x = window.width-popup.width;

            popup.y = mappedPos.y - popup.height;
            if(popup.y < 0)
                popup.y += popup.height + textEditor.height;
        }

        ModalPopupBehavior {
            id: modalPopup
            consumeCancelClick: false
            whenAlso: !mouseArea.pressed && textEditor.activeFocus
            delay: 300
            onPrepareToShow: copyPastePopup.positionPopout(popup, window)
            onCancelledByClick: copyPastePopup.wasCancelledByClick = true
            popupComponent: copyPasteButtons
        }
    }
}

