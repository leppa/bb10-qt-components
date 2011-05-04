import QtQuick 1.1

CheckBox {
    id: radioButton

    function __handleChecked() {
        if (!radioButton.checked)
            radioButton.checked = true;
    }
}
