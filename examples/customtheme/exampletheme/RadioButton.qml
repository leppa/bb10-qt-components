import QtQuick 1.1
import "../../../components" as Components

Components.RadioButton{
    style.background: Image{
        source: "images/radiobutton_normal.png"
    }

	style.checkmark:Image {
	visible: checked
        anchors.centerIn:parent
        source: "images/radiobutton_check.png"
        Behavior on opacity { NumberAnimation{easing.type:Easing.OutCubic}}
    }
}

