import QtQuick 1.1
import QtLabs.components 1.0   // RangeModel
import QtLabs.components.styles 1.0

Item {
    id: slider

    implicitWidth: !contents.isVertical ? style.minimumWidth
        : Math.max(style.minimumHeight, handleLoader.item.implicitHeight)
    implicitHeight: contents.isVertical ? style.minimumWidth
        : Math.max(style.minimumHeight, handleLoader.item.implicitHeight)

    property SliderStyle style: SliderStyle {
        progressColor: userStyle.progressColor != "" ?
            userStyle.progressColor : themeStyle.progressColor

        backgroundColor: userStyle.backgroundColor != "" ?
            userStyle.backgroundColor : themeStyle.backgroundColor

        pinWidth: userStyle.pinWidth != undefined ?
            userStyle.pinWidth : themeStyle.pinWidth

        minimumWidth: userStyle.minimumWidth != undefined ?
            userStyle.minimumWidth : themeStyle.minimumWidth

        minimumHeight: userStyle.minimumHeight != undefined ?
            userStyle.minimumHeight : themeStyle.minimumHeight
    }

    property SliderStyle themeStyle: SliderStyle {
        pinWidth: 0
        minimumWidth: 0
        minimumHeight: 0
    }

    property Component handle
    property Component groove
    property Component valueIndicator

    // The default implementation for label hides decimals until it hits a
    // floating point value at which point it keeps decimals
    property bool useDecimals: false

    property bool animateHandle: true
    property string showValueIndicator: "above" // one of "above", "below", "left", "right", or "none"
    property int valueIndicatorMargin: 10
    property alias handleItem: shadowHandle
    property alias contentWidth: contents.width

    function formatValue(v) {
        if (parseInt(v) != v)
            useDecimals = true;

        return useDecimals ? (v.toFixed(2)) : v;
    }

    Connections {
        target: rangeModel
        onMaximumChanged: slider.useDecimals = false;
        onMinimumChanged: slider.useDecimals = false;
        onStepSizeChanged: slider.useDecimals = false;
    }

    Item {
        id: contents

        width: isVertical ? slider.height : slider.width
        height: isVertical ? slider.width : slider.height
        rotation: isVertical ? -90 : 0

        anchors.centerIn: slider
        property bool isVertical: widget.orientation == Qt.Vertical
        property real halfHandleWidth: handleLoader.width/2

        Loader {
            id: grooveLoader
            anchors.fill: parent
            sourceComponent: slider.groove

            property alias widget: slider
            property real handlePosition: handleLoader.x
            function positionForValue(value) {
                return rangeModel.positionForValue(value);
            }
        }

        Loader {
            id: handleLoader
            transform: Translate { x: -contents.halfHandleWidth }
            anchors.verticalCenter: grooveLoader.verticalCenter

            property alias widget: slider
            sourceComponent: slider.handle

            x: shadowHandle.x
            Behavior on x {
                id: behavior
                enabled: !mouseArea.drag.active && slider.animateHandle

                PropertyAnimation {
                    duration: behavior.enabled ? 150 : 0
                    easing.type: Easing.OutSine
                }
            }
        }

        Item {
            id: shadowHandle
            width: handleLoader.width
            height: handleLoader.height
            transform: Translate { x: -contents.halfHandleWidth }
            onXChanged: valueIndicatorLoader.indicatorText = slider.formatValue(rangeModel.valueForPosition(shadowHandle.x));
            Component.onCompleted: {
                if (!slider.animateHandle)
                    shadowHandle.x = rangeModel.position;
                else {
                    slider.animateHandle = false;
                    shadowHandle.x = rangeModel.position;
                    slider.animateHandle = true;
                }
            }
        }

        Loader {
            id: valueIndicatorLoader

            anchors.margins: valueIndicatorMargin
            transform: Translate { x: -contents.halfHandleWidth }
            rotation: contents.isVertical ? 90 : 0
            visible: (actualPosition != undefined)

            property string indicatorText
            property alias widget: slider
            sourceComponent: slider.valueIndicator //mm Only load while handle is pressed?

            property variant actualPosition
            actualPosition: {
                switch(showValueIndicator.toLowerCase()) {
                case "above": return (!contents.isVertical ? Qt.AlignTop : Qt.AlignRight);
                case "below": return (!contents.isVertical ? Qt.AlignBottom : Qt.AlignLeft);
                case "left": return (!contents.isVertical ? Qt.AlignLeft : Qt.AlignTop);
                case "right": return (!contents.isVertical ? Qt.AlignRight : Qt.AlignBottom);
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
