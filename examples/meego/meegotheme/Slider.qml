import QtQuick 1.1
import "../../../components" as Components

Components.Slider{

    // implementation

    minimumWidth: 325;
    minimumHeight: 30;

    pinWidth: 0

    groove: Item {
        opacity: enabled ? 1.0 : 0.7

        BorderImage {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            source: "image://theme/meegotouch-slider-background-horizontal"
            border { left: 4; top: 4; right: 4; bottom: 4 }
        }

        BorderImage {
            source: "image://theme/meegotouch-slider-elapsed-background-horizontal"
            border { left: 4; top: 4; right: 4; bottom: 4 }
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left; right: parent.right
                leftMargin: {
                    if(minimumValue >= 0) return (!inverted ? 0 : handlePosition);  // slider has no negative values, else...
                    return (!(value<0) != !(inverted) ? handlePosition : positionForValue(0));    // !(x) != !(y) is logical exclusive or
                }
                rightMargin: {
                    if(minimumValue >= 0) return (!inverted ? parent.width-handlePosition : 0); // slider has no negative values, else...
                    return parent.width - (!(value<0) != !(inverted) ? positionForValue(0) : handlePosition); // !(x) != !(y) is logical exclusive or
                }
            }
        }
    }

    handle: Image {
        source: styledItem.pressed ?
            "image://theme/meegotouch-slider-handle-background-pressed-horizontal" :
            "image://theme/meegotouch-slider-handle-background-horizontal"
    }

    valueIndicator: BorderImage {
        id: indicatorBackground
        source: "image://theme/meegotouch-slider-handle-value-background"
        border { left: 12; top: 12; right: 12; bottom: 12 }

        width: label.width + 50
        height: 80

        Image { id: arrow }

        state: styledItem.valueIndicatorPosition
        states: [
            State {
                name: "Top"
                PropertyChanges {
                    target: arrow
                    source: "image://theme/meegotouch-slider-handle-label-arrow-down"
                }
                AnchorChanges {
                    target: arrow
                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            },
            State {
                name: "Bottom"
                PropertyChanges {
                    target: arrow
                    source: "image://theme/meegotouch-slider-handle-label-arrow-up"
                }
                AnchorChanges {
                    target: arrow
                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            },
            State {
                name: "Left"
                PropertyChanges {
                    target: arrow
                    source: "image://theme/meegotouch-slider-handle-label-arrow-right"
                }
                AnchorChanges {
                    target: arrow
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            },
            State {
                name: "Right"
                PropertyChanges {
                    target: arrow
                    source: "image://theme/meegotouch-slider-handle-label-arrow-right"
                }
                AnchorChanges {
                    target: arrow
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        ]

        Label {
            id: label
            anchors.centerIn: parent
            styleObjectName: "MSliderHandleLabel"
            text: styledItem.value
            color: "black"
        }

        // Native libmeegotouch slider value indicator pops up 100ms after pressing
        // the handle... but hiding happens without delay.
        visible: styledItem.valueIndicatorVisible && styledItem.pressed
        Behavior on visible {
            enabled: !indicatorBackground.visible
            PropertyAnimation {
                duration: 100
            }
        }
    }
}

