import QtQuick 1.1
import "../../../components" as Components
import com.meego.themebridge 1.0

Components.TextArea {
    id: textField

    leftMargin: meegostyle.current.get("paddingLeft")
    rightMargin: meegostyle.current.get("paddingRight")
    topMargin: meegostyle.current.get("paddingTop") + __documentMargin
    bottomMargin: meegostyle.current.get("paddingBottom") + __documentMargin
    property int __documentMargin: 4 //mm fudge copied from master branch

    placeholderText: ""

    Style {
        id: meegostyle
        styleClass: "MTextEditStyle"
        mode: textField.activeFocus ? "selected" : "default"
    }

    font: meegostyle.current.get("font")
    textColor: meegostyle.current.get("textColor")

    background: BorderImage {
        source: textField.activeFocus ?
                "image://theme/meegotouch-textedit-background-selected" :
                "image://theme/meegotouch-textedit-background"
        border {
            left: textField.leftMargin; right: textField.rightMargin
            top: textField.topMargin; bottom: textField.bottomMargin
        }
    }
}

