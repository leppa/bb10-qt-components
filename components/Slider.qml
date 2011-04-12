/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project on Qt Labs.
**
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions contained
** in the Technology Preview License Agreement accompanying this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
****************************************************************************/

import QtQuick 1.1

import "./styles"       // SliderStylingProperties
import "./styles/default" as DefaultStyles

Item {
    id: slider

    property alias value: rangeModel.value

    property alias minimumValue: rangeModel.minimumValue
    property alias maximumValue: rangeModel.maximumValue
    property alias stepSize: rangeModel.stepSize

    property int orientation: Qt.Horizontal
    property alias inverted: rangeModel.inverted
    property bool updateValueWhileDragging: true
    property alias pressed: mouseArea.pressed

    property bool animateHandle: true
    property string showValueIndicator: "above" // one of "above", "below", "left", "right", or "none"
    property int valueIndicatorMargin: 10

    function formatValue(v) {
        if (parseInt(v) != v)
            useDecimals = true;

        return useDecimals ? (v.toFixed(2)) : v;
    }

    property SliderStylingProperties styling: SliderStylingProperties {

        groove: defaultStyle.groove
        handle: defaultStyle.handle
        valueIndicator: defaultStyle.valueIndicator
        pinWidth: handleLoader.width/2

        minimumWidth: defaultStyle.minimumWidth
        minimumHeight: defaultStyle.minimumHeight
    }

    // implementation

    // The default implementation for label hides decimals until it hits a
    // floating point value at which point it keeps decimals
    property bool useDecimals: false

    implicitWidth: contents.isVertical ? Math.max(styling.minimumHeight, handleLoader.item.implicitHeight) : styling.minimumWidth
    implicitHeight: contents.isVertical ? styling.minimumWidth : Math.max(styling.minimumHeight, handleLoader.item.implicitHeight)

    DefaultStyles.SliderStyle { id: defaultStyle }

    Item {
        id: contents

        width: isVertical ? slider.height : slider.width
        height: isVertical ? slider.width : slider.height
        rotation: isVertical ? -90 : 0

        anchors.centerIn: slider
        property bool isVertical: orientation == Qt.Vertical
        property real halfHandleWidth: handleLoader.width/2

        // The width of the "pin" that the handle is attached to, defines
        // how much outside the groove the head of the handle extends
        property real halfPinWidth: styling.pinWidth/2

        RangeModel {
            id: rangeModel
            minimumValue: 0.0
            maximumValue: 1.0
            stepSize: 0

            inverted: false
            positionAtMinimum: contents.halfPinWidth // relative to *center* of handle
            positionAtMaximum: contents.width - contents.halfPinWidth
            onMaximumValueChanged: useDecimals = false;
            onMinimumValueChanged: useDecimals = false;
            onStepSizeChanged: useDecimals = false;
        }

        Loader {
            id: grooveLoader
            anchors.fill: parent
            sourceComponent: styling.groove

            property alias styledItem: slider
            property real handlePosition: handleLoader.x
            function positionForValue(value) {
                return rangeModel.positionForValue(value);
            }
        }

        Loader {
            id: handleLoader
            transform: Translate { x: -contents.halfHandleWidth }
            anchors.verticalCenter: grooveLoader.verticalCenter

            property alias styledItem: slider
            sourceComponent: styling.handle

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
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            anchors.leftMargin: -contents.halfHandleWidth
            anchors.rightMargin: -contents.halfHandleWidth

            drag.target: shadowHandle
            drag.axis: Drag.XAxis
            drag.minimumX: rangeModel.positionAtMinimum
            drag.maximumX: rangeModel.positionAtMaximum

            onPressed: {
                // Compensate for mouse area being wider than the slider itself
                var newX = mouse.x - contents.halfHandleWidth;

                // Debounce the press: a press event inside the handler should not
                // change its position, the user needs to drag it.
                if (Math.abs(newX - shadowHandle.x) > contents.halfHandleWidth)
                    rangeModel.position = newX;
            }

            onReleased: {
                // If we don't update while dragging, this is the only
                // moment that the rangeModel is updated.
                if (!slider.updateValueWhileDragging)
                    rangeModel.position = shadowHandle.x;
            }
        }

        Loader {
            id: valueIndicatorLoader

            anchors.margins: valueIndicatorMargin
            transform: Translate { x: -contents.halfHandleWidth }
            rotation: contents.isVertical ? 90 : 0
            visible: (actualPosition != undefined)

            property string indicatorText
            property alias styledItem: slider
            sourceComponent: styling.valueIndicator //mm Only load while handle is pressed?

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

    property bool __ready: false
    Component.onCompleted: {
        // It's probably not enough
        __ready = true;
    }

    // We need Binding elements that will not be broken
    // when we assign to the "value" property
    Binding {
        property: "value"
        target: rangeModel
        value: slider.value
        when: __ready && !mouseArea.pressed
    }

    Binding {
        property: "value"
        target: slider
        value: rangeModel.value
        when: __ready && mouseArea.pressed
    }

    // rangeModel position normally follow shadowHandle, except when
    // 'updateValueWhileDragging' is false. In this case it will only follow
    // if the user is not pressing the handle.
    Binding {
        when: updateValueWhileDragging || !mouseArea.pressed
        target: rangeModel
        property: "position"
        value: shadowHandle.x
    }

    // During the drag, we simply ignore position set from the rangeModel, this
    // means that setting a value while dragging will not "interrupt" the
    // dragging activity.
    Binding {
        when: !mouseArea.drag.active
        target: shadowHandle
        property: "x"
        value: rangeModel.position
    }
}
