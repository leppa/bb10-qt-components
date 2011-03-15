import QtQuick 1.1
import "./styles/default" as DefaultStyles

CheckBox {
    id: radioButton

    // implementation

    styling.checkmark: defaultStyle.checkmark
    styling.background: defaultStyle.background

    DefaultStyles.RadioButtonStyle { id: defaultStyle}
}
