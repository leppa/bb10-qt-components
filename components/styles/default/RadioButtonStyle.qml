import QtQuick 1.1
import "tools" as StyleTools

QtObject {
    property int width: 32
    property int height: 32

    property Component background: Component {
        Item {
            width: styledItem.implicitWidth; height: styledItem.implicitHeight
            Rectangle { // Background center fill
                anchors.fill: parent
                anchors.margins: 1
                radius: width/2
                color: "white"
            }
            Image {
                opacity: enabled ? 1 : 0.7
                source: "images/radiobutton_normal.png"
                fillMode: Image.Stretch
                anchors.centerIn: parent
            }
            Image {
                anchors.centerIn: parent
                source: "images/radiobutton_check.png"
                opacity: (!enabled && checked) || pressed == true ? 0.5 : (!checked ? 0 : 1)
                Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
            }
        }
    }
}
