import QtQuick 1.1
import "../templates"

ButtonRow {
    id: buttonRow

    function prepareItem(item) {
        if (buttonRow.exclusive && item["checkable"] !== undefined)
            item.checkable = true;
    }

    function setPosition(button, position) {
        if (button.visible && button.hasOwnProperty("__borderRect"))
            button.__borderRect.border.color = __stylePositions[position];
    }

    property variant __stylePositions: {
        single: "black",
        first: "red",
        middle: "green",
        last: "blue"
    }
}
