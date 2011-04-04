import QtQuick 1.1
import "../../../components/styles"

ButtonStylingProperties {
    leftMargin: 18
    topMargin: 6
    rightMargin: 18
    bottomMargin: 6

    minimumHeight: 80

    label: Component {
        Text {
            text: styledItem.text
            color: "white"
            font.bold: true
            font.pixelSize: 26
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    background: Component {
        BorderImage {
            source: styledItem.pressed ?
                  "../images/dialer/bt_endcall_over.png"
                : "../images/dialer/bt_endcall.png"
            border.left: 20
            border.top: 20
            border.right: 20
            border.bottom: 20
        }
    }
}
