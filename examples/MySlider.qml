import QtQuick 1.1
import "../components"
import "../components/styles/default"

Slider {
    id: slider

    SliderStyle { id: defaultStyle }

    Loader {
        id: grooveLoader
        anchors.fill: parent
        sourceComponent: defaultStyle.groove

        property alias styledItem: slider
    }

    handle: Item {
        anchors.verticalCenter: parent.verticalCenter
        onXChanged:
            valueIndicatorLoader.indicatorText = slider.formatValue(slider.value)
        Behavior on x {
            id: behavior
            enabled: !dragging && slider.animateHandle

            PropertyAnimation {
                duration: behavior.enabled ? 150 : 0
                easing.type: Easing.OutSine
            }
        }
        Loader {
            id: handleLoader
            anchors.centerIn: parent

            property alias styledItem: slider
            sourceComponent: defaultStyle.handle

        }

        Loader {
            id: valueIndicatorLoader

            anchors.margins: valueIndicatorMargin
            rotation: slider.orientation == Qt.Horizontal ? 0 : 90
            visible: (actualPosition != undefined)

            property string indicatorText
            property alias styledItem: slider
            sourceComponent: defaultStyle.valueIndicator

            property variant actualPosition
            actualPosition: {
                switch(showValueIndicator.toLowerCase()) {
                case "above": return (orientation == Qt.Horizontal ? Qt.AlignTop : Qt.AlignRight);
                case "below": return (orientation == Qt.Horizontal ? Qt.AlignBottom : Qt.AlignLeft);
                case "left": return (orientation == Qt.Horizontal ? Qt.AlignLeft : Qt.AlignTop);
                case "right": return (orientation == Qt.Horizontal ? Qt.AlignRight : Qt.AlignBottom);
                default: return undefined;
                }
            }
            Component.onCompleted: positionValueIndicator()
            onActualPositionChanged: positionValueIndicator()

            function positionValueIndicator() {
                anchors.top = undefined; anchors.bottom = undefined;
                anchors.left = undefined; anchors.right = undefined;
                anchors.horizontalCenter =
                        (actualPosition == Qt.AlignTop || actualPosition == Qt.AlignBottom) ?
                            handleLoader.horizontalCenter : undefined;

                anchors.verticalCenter =
                        (actualPosition == Qt.AlignLeft || actualPosition == Qt.AlignRight) ?
                            handleLoader.verticalCenter : undefined;

                switch(actualPosition) {
                case Qt.AlignTop: anchors.bottom = handleLoader.top; break;
                case Qt.AlignBottom: anchors.top = handleLoader.bottom; break;
                case Qt.AlignLeft: anchors.right = handleLoader.left; break;
                case Qt.AlignRight: anchors.left = handleLoader.right; break;
                }
            }
        }
    }
}
