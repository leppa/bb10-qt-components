import QtQuick 1.1
import "../../../components" as Components

Components.Button {
    style.leftMargin:12
    style.rightMargin:1
    style.minimumWidth:100

    style.background: BorderImage {
        source: pressed ? "images/button_pressed.png" :
                "images/button_normal.png"
        border.top:8
        border.bottom:8
        border.left:8
        border.right:8
    }
}

