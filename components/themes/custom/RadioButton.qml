import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.RadioButton {
    themeStyle {
        minimumWidth: 32
        minimumHeight: 32
        backgroundColor: "white"
    }

    Item {
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: width / 2
            color: style.backgroundColor
        }
        Image {
            opacity: enabled ? 1 : 0.7
            fillMode: Image.Stretch
            anchors.centerIn: parent
            source: "images/radiobutton_normal.png"
        }
        Image {
            anchors.centerIn: parent
            source: "images/radiobutton_check.png"
            opacity: (!enabled && checked) || pressed == true ? 0.5 : (!checked ? 0 : 1)
            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
        }
    }
}
