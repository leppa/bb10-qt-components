import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.Slider {
    themeStyle {
        progressColor: "blue"
        backgroundColor: "white"

        pinWidth: 30
        minimumWidth: 200
        minimumHeight: 40
    }

    groove: Item {
        opacity: enabled ? 1.0 : 0.7

        Rectangle {
            color: style.backgroundColor
            anchors.fill: sliderBackground
            anchors.margins: 1
            radius: 2
        }

        Rectangle {
            height: 10
            radius: 4
            color: style.progressColor
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

        BorderImage {
            id: sliderBackground
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            border.top: 2
            border.bottom: 2
            border.left: 12
            border.right: 12
            source: "images/slider.png"
        }
    }

    handle: Item {
        width: handleImage.width
        height: handleImage.height
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: handleImage
            Rectangle {
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -1
                width: parent.width - 7
                height: parent.height - 7
                smooth: true
                color: style.backgroundColor
                radius: Math.floor(parent.width / 2)
                z: -1   // behind the image
            }
            anchors.centerIn: parent;
            source: "images/handle.png"
            smooth: true
        }
    }

    valueIndicator: Rectangle {
        width: valueText.width + 20
        height: valueText.height + 20
        color: "gray"
        opacity: pressed ? 0.9 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
        radius: 5

        Text {
            id: valueText
            anchors.margins: 10
            anchors.centerIn: parent
            text: indicatorText
        }
    }
}
