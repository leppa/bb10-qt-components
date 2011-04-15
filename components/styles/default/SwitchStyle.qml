import QtQuick 1.1

QtObject {

    property Component groove: Component {
        Item {
            opacity: enabled ? 1 : 0.7
            Item { // Clipping container of the positive and negative groove highlight
                anchors.fill: parent
                anchors.margins: 2
                clip: true
                Item { // The highlight item is twice the width of there switch, clipped by its parent,
                       // and sliding back and forth keeping the center under the handle
                    height: parent.height
                    width: 2*parent.width
                    x: handleCenterX-parent.width-parent.anchors.leftMargin
                }
            }

            BorderImage { // Rounded border
                anchors.fill: parent
                source: "images/lineedit_normal.png"
                border { left: 6; right: 6; top: 3; bottom: 3 }
                smooth: true
            }
        }
    }

    property Component handle: Component {
        Item {
            width: 42
            BorderImage {
                anchors.fill: parent
                opacity: enabled ? 1 : 0.7
                smooth: true
                source: pressed ? "images/button_pressed.png" : "images/button_normal.png"
                border { left: 4; top: 4; right: 4; bottom: 4 }
            }
            Behavior on x { NumberAnimation { easing.type: Easing.OutCubic; duration: 200 } }
        }
    }
}
