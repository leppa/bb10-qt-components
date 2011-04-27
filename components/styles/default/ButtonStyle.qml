import QtQuick 1.1

QtObject {

    property Component background: Component {
        Item {
            implicitWidth: row.implicitWidth + 10
            implicitHeight: row.implicitHeight + 10

            opacity: enabled ? 1 : 0.7
            clip: true  // clip connected buttons, as they overlap to remove the rounded edjes
            property bool isPositioned: position != "only" // only evaluate for rows and columns

            Item {
                anchors.fill: parent
                property int buttonborder: 8
                // Give connected buttons a negative styling margin, to make
                // them overlap and the rounded edge can be clipped away
                anchors.leftMargin:   isPositioned && (position == "rightmost"  || position =="h_middle") ? - buttonborder : 0
                anchors.rightMargin:  isPositioned && (position == "leftmost"   || position =="h_middle") ? - buttonborder : 0
                anchors.topMargin:    isPositioned && (position == "bottom"     || position =="v_middle") ? - buttonborder : 0
                anchors.bottomMargin: isPositioned && (position == "top"        || position =="v_middle") ? - buttonborder : 0

                BorderImage {
                    anchors.fill: parent
                    smooth: true
                    source: pressed || checked ? "images/button_pressed.png" : "images/button_normal.png";
                    border.left: 6; border.top: 6
                    border.right: 6; border.bottom: 6
                }
            }

            Item {
                anchors.centerIn: parent
                implicitWidth: row.implicitWidth
                implicitHeight: row.implicitHeight

                opacity: enabled ? 1 : 0.5
                transform: Translate {
                    x: pressed || checked ? 1 : 0
                    y: pressed || checked ? 1 : 0
                }

                Row {
                    id: row
                    anchors.centerIn: parent
                    spacing: 4
                    Image {
                        source: iconSource
                        anchors.verticalCenter: parent.verticalCenter
                        fillMode: Image.Stretch //mm Image should shrink if button is too small, depends on QTBUG-14957
                    }

                    Text {
                        color: "black"
                        anchors.verticalCenter: parent.verticalCenter
                        text: styledItem.text
                        horizontalAlignment: Text.Center
                        elide: Text.ElideRight //mm can't make layout work as desired without implicit size support, see QTBUG-14957
                    }
                }
            }

        }
    }
}
