import QtQuick 1.1
import "../../../components"

Rectangle {
    color: "#222222"

    signal endCall();
    property url image

    MouseArea {
        anchors.fill: parent
    }

    Image {
        id: contactPhoto
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        source: (image != "") ? image : "../images/dialer/photo_nobody.png"
    }

    Row {
        id: buttonBar
        spacing: 0
        anchors.top: contactPhoto.bottom
        anchors.topMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            styling: ImageButtonStyle {
                source: "../images/dialer/bt_dialer.png"
            }
        }
        Button {
            styling: ImageButtonStyle {
                source: "../images/dialer/bt_mute.png"
            }
        }
        Button {
            styling: ImageButtonStyle {
                source: "../images/dialer/bt_mute.png"
            }
        }
    }

    Button {
        text: "END CALL"
        styling: BigButtonStyle { }

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.leftMargin: 18
        anchors.rightMargin: 18
        anchors.bottomMargin: 6

        onClicked: endCall();
    }

    BorderImage {
        source: "../images/shadow_top.png"
        border.left: 20
        border.right: 20
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.top
    }
}
