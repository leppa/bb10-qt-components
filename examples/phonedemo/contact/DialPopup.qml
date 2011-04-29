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
            text: "bla"
            delegate: Image {
                source: "../images/dialer/bt_dialer.png"
            }
        }
        Button {
            delegate: Image {
                source: "../images/dialer/bt_mute.png"
            }
        }
        Button {
            delegate: Image {
                source: "../images/dialer/bt_mute.png"
            }
        }
    }

    Button {
        text: "END CALL"

        delegate: BorderImage {
            source: widget.pressed ?
                "../images/dialer/bt_endcall_over.png"
                : "../images/dialer/bt_endcall.png"
            border.left: 20
            border.top: 20
            border.right: 20
            border.bottom: 20

            Text {
                anchors.fill: parent
                text: widget.text
                color: "white"
                font.bold: true
                font.pixelSize: 26
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

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
