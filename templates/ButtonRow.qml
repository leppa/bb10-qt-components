import QtQuick 1.1
import "private/ButtonGroup.js" as Behavior

/*
   Class: ButtonRow
   A ButtonRow allows you to group Buttons in a row. It provides a selection-behavior as well.

   Note: This component don't support the enabled property.
   If you need to disable it you should disable all the buttons inside it.

   <code>
       ButtonRow {
           Button { text: "Left" }
           Button { text: "Right" }
       }
   </code>
*/
Row {
    id: buttonRow

    /*
     * Property: exclusive
     * [bool=true] Specifies the grouping behavior. If enabled, the checked property on buttons contained
     * in the group will be exclusive.
     *
     * Note that a button in an exclusive group will allways be checkable
     */
    property bool exclusive: true

    /*
     * Property: checkedButton
     * [string] Contains the last checked Button.
     */
    property Item checkedButton     // read-only

    // implementation
    onExclusiveChanged: Behavior.rebuild()

    Component.onCompleted: {
        var stylePositions = {
            single: "",
            first: "leftmost",
            middle: "h_middle",
            last: "rightmost" };

        Behavior.create(buttonRow, {
            exclusive: exclusive,
            prepareItem: function(item) {
                if (buttonRow.exclusive && item["checkable"] !== undefined)
                    item.checkable = true;
            },
            setPosition: function(button, position) {
                if (button.visible && Behavior.isButton(button))
                    button.__position = stylePositions[position];
            }
        });
    }

    Component.onDestruction: Behavior.destroy()
}
