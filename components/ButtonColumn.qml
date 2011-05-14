import QtQuick 1.1
import "private/ButtonGroup.js" as Behavior

/*
   Class: ButtonColumn
   A ButtonColumn allows you to group Buttons in a column. It provides a selection-behavior as well.

   Note: This component don't support the enabled property.
   If you need to disable it you should disable all the buttons inside it.

   <code>
       ButtonColumn {
           Button { text: "Top" }
           Button { text: "Bottom" }
       }
   </code>
*/
Column {
    id: buttonColumn

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
    property Item checkedButton  // read-only

    // implementation
    onExclusiveChanged: Behavior.updateButtons()

    Component.onCompleted: {
        var stylePositions = {
            single: "",
            first: "top",
            middle: "v_middle",
            last: "bottom" };

        Behavior.create(buttonColumn, {
            exclusive: exclusive,
            prepareItem: function(item) {
                if (buttonColumn.exclusive && item["checkable"] !== undefined)
                    item.checkable = true;
            },
            setPosition: function(button, position) {
                if (button.visible && Behavior.isButton(button))
                    button.__position = stylePositions[position];
            },
            resizeChildren: function() {
                 Behavior.buttons.forEach(function(item, i) {
                     if (Behavior.isButton(item) && item.visible) {
                         item.anchors.left = buttonColumn.left;
                         item.anchors.right = buttonColumn.right;
                     }
                 });
            }
        });
    }

    Component.onDestruction: Behavior.destroy()
}
