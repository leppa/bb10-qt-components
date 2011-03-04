import QtQuick 1.0
import "../../../components" as Components

Components.Slider{

    minimumWidth:160
    minimumHeight:32

    handle: BorderImage {
        width:20
        source: pressed ? "images/button_pressed.png" :
                "images/button_normal.png"
        border.top:6 ; border.bottom:6
        border.left:6 ; border.right:6
    }

    valueIndicator:
        BorderImage {
            id: name
            source: "images/label.png"
            border.top: 12
            border.bottom: 12
            height: 30
            Text {
                anchors.centerIn:parent
                anchors.verticalCenterOffset:-4
                text: indicatorText
                color: "white"
            }
            opacity: pressed
            Behavior on opacity { NumberAnimation{easing.type:Easing.OutCubic  } }
        }


    groove: Item {
        BorderImage {
            height:12
            width:parent.width
            anchors.verticalCenter:parent.verticalCenter
            source: "images/edit_normal.png"
            border.top:4
            border.bottom:4
            border.left:4
            border.right:4
        }
    }
}
