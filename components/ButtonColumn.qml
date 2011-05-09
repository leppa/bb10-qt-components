import QtQuick 1.1
import "../templates"

ButtonColumn {
    id: buttonColumn

    function prepareItem(item) {
        if (buttonColumn.exclusive && item["checkable"] !== undefined)
            item.checkable = true;
    }

    function setPosition(button, position) {
        if (button.visible && __isButton(button))
            button.__position = __stylePositions[position];
    }

    function resizeChildren(items) {
         items.forEach(function(item, i) {
             if (__isButton(item) && item.visible) {
                 item.anchors.left = buttonColumn.left;
                 item.anchors.right = buttonColumn.right;
             }
         });
    }

    property variant __stylePositions: {
        single: "",
        first: "top",
        middle: "v_middle",
        last: "bottom"
    }

    function __isButton(item) {
        return item && item.hasOwnProperty("__position");
    }
}
