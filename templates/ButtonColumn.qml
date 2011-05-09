import QtQuick 1.1
import "private/ButtonGroup.js" as BG

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
    id: buttonRow

     /*
      * Property: exclusive
      * [bool=true] Specifies the grouping behavior. If enabled, the checked property on buttons contained
      * in the group will be exclusive.
      *
      * Note that a Button in an exclusive group will allways be checkable
      */
     property bool exclusive: true

     /*
      * Property: checkedButton
      * [Item] Contains the last checked Item.
      */
     property Item checkedButton

    onExclusiveChanged: BG.rebuild()

    function prepareItem(item) { }
    function setPosition(button, position) { }
    function resizeChildren(items) { }

    Component.onCompleted: {
        BG.create(buttonRow, {
            exclusive: exclusive,
            prepareItem: prepareItem,
            setPosition: setPosition,
            resizeChildren: resizeChildren
            });
    }

    Component.onDestruction: BG.destroy()
}
