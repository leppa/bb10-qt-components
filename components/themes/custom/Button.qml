import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.Button {
    id: button

    themeStyle {
        textColor: "black"
        backgroundColor: "white"
        leftMargin: 10
        topMargin: 10
        rightMargin: 10
        bottomMargin: 10
        minimumWidth: 90
        minimumHeight: 32
    }

    Item {
        id: bg
        anchors.fill: parent
        opacity: enabled ? 1 : 0.7
        clip: true  // clip connected buttons, as they overlap to remove the rounded edjes
        property bool isPositioned: position != "only" // only evaluate for rows and columns

        Item {
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

            Rectangle { // Background center fill
                anchors.fill: parent
                anchors.margins: 1
                radius: 5
                color: style.backgroundColor
            }
            BorderImage {
                anchors.fill: parent
                smooth: true
                source: pressed || checked ? "images/button_pressed.png"
                    : "images/button_normal.png";
                border {left: 6; top: 6; right: 6; bottom: 6; }
            }
        }

        // Draw straight border lines between connected buttons
        Rectangle {
            width: 1
            visible: bg.isPositioned && !checked && !pressed && (position == "rightmost" || position == "h_middle")
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottomMargin: 2
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            opacity: 0.4
            color: "white"
        }
        Rectangle {
            width: 1
            opacity: 0.4
            visible: bg.isPositioned && !checked && !pressed && (position == "leftmost" || position == "h_middle")
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.bottomMargin: 2
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            color: "black"
        }
    }

    Item {
        anchors.fill: parent
        opacity: enabled ? 1 : 0.5

        transform: Translate {
            x: pressed || checked ? 1 : 0
            y: pressed || checked ? 1 : 0
        }

        Row {
            id: rowItem
            spacing: 4
            anchors.centerIn: parent

            Image {
                source: iconSource
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.Stretch //mm Image should shrink if button is too small, depends on QTBUG-14957
            }
            Text {
                color: button.style.textColor
                anchors.verticalCenter: parent.verticalCenter
                text: widget.text
                horizontalAlignment: Text.Center
                elide: Text.ElideRight //mm can't make layout work as desired without implicit size support, see QTBUG-14957
            }
        }
    }

    implicitWidth: Math.max(rowItem.implicitWidth + style.leftMargin + style.rightMargin,
                            style.minimumWidth)
    implicitHeight: Math.max(rowItem.implicitHeight + style.topMargin + style.bottomMargin,
                             style.minimumHeight)
}
