import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.CheckBox {
    themeStyle {
        minimumWidth: 32
        minimumHeight: 32
        backgroundColor: "white"
    }

    Item {
        anchors.fill: parent
        opacity: enabled ? 1 : 0.7

        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: 5
            color: style.backgroundColor
        }

        BorderImage {
            anchors.fill: parent
            source: "images/lineedit_normal.png"
            smooth: true
            border.left: 6; border.top: 3
            border.right: 6; border.bottom: 3
        }

        Image {
            anchors.centerIn: parent
            source: "images/checkbox_check.png"
            opacity: (!enabled && checked) || pressed == true ? 0.5 : (!checked ? 0 : 1)
            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
        }
    }
}
