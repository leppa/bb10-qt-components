import QtQuick 1.1
import "../../../components" as Components

Components.CheckBox{
    style.background: BorderImage {
        source: "images/edit_normal.png"
        border.top:6
        border.bottom:6
        border.left:6
        border.right:8
    }
    style.checkmark:Image {
	visible: checked
        anchors.centerIn:parent
        source: "images/checkbox_check.png"
        Behavior on opacity { NumberAnimation{easing.type:Easing.OutCubic}}
    }
}

