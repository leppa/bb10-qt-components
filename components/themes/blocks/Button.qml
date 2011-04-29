import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.Button {
    id: button

    themeStyle {
        textColor: "black"
        backgroundColor: "silver"
        leftMargin: 10
        topMargin: 10
        rightMargin: 2
        bottomMargin: 2
        minimumWidth: 90
        minimumHeight: 30
    }

    clip: true

    Item {
        anchors.fill: parent
        anchors.margins: 1

        Rectangle {
            border.width: 1
            opacity: enabled ? 1.0 : 0.7
            color: !checked && !pressed ? style.backgroundColor
                : Qt.tint(style.backgroundColor, "#30000000")
            anchors {
                fill: parent
                // Give connected buttons a negative style margin, to make
                // them overlap and the rounded edge can be clipped away
                leftMargin: (position == "rightmost" ||
                             position =="h_middle") ? -style.leftMargin : 0
                topMargin: (position == "bottom" ||
                            position =="v_middle") ? -style.bottomMargin : 0
                rightMargin: (position == "leftmost" ||
                              position =="h_middle") ? -style.rightMargin : 0
                bottomMargin: (position == "top" ||
                               position =="v_middle") ? -style.topMargin : 0
            }
        }
    }

    Text {
        id: label
        text: widget.text
        font.pixelSize: 12
        elide: Text.ElideRight
        color: button.style.textColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    implicitWidth: Math.max(label.implicitWidth + style.leftMargin + style.rightMargin,
                            style.minimumWidth)
    implicitHeight: Math.max(label.implicitHeight + style.topMargin + style.bottomMargin,
                             style.minimumHeight)
}
