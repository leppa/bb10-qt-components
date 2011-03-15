import QtQuick 1.0
import "../../../components" as Components

Components.Button {
    styling.leftMargin:12
    styling.rightMargin:1
    styling.minimumWidth:100

    styling.background: BorderImage {
        source: pressed ? "images/button_pressed.png" :
                "images/button_normal.png"
        border.top:8
        border.bottom:8
        border.left:8
        border.right:8
    }
}

