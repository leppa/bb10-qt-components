import QtQuick 1.1
import "./styles/default" as DefaultStyles
import "./styles"      // CheckBoxStylingProperties

CheckBox {
    id: radioButton

    property CheckBoxStylingProperties styling: CheckBoxStylingProperties {
        background: defaultStyle.background
        width: defaultStyle.width
        height: defaultStyle.height
    }

    // implementation
    DefaultStyles.RadioButtonStyle { id: defaultStyle}
}
