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

    property string showValueIndicator: "above" // one of "above", "below", "left", "right", or "none"

    property bool animateHandle: true
    property int valueIndicatorMargin: 10

    function formatValue(v) {
        if (parseInt(v) != v)
            useDecimals = true;

        return useDecimals ? (v.toFixed(2)) : v;
    }

    default property alias _data: content.data
    property Item handle: null
    property bool dragging: mouseArea.drag.active

    // implementation

    // The default implementation for label hides decimals until it hits a
    // floating point value at which point it keeps decimals
    property bool useDecimals: false

    implicitWidth: contents.isVertical ? 10 : 300
    implicitHeight: contents.isVertical ? 300 : 10

    Item {
        id: contents

        width: isVertical ? slider.height : slider.width
        height: isVertical ? slider.width : slider.height
        rotation: isVertical ? -90 : 0

        anchors.centerIn: slider
        property bool isVertical: orientation == Qt.Vertical
        property real halfHandleWidth: handle.width/2

        // The width of the "pin" that the handle is attached to, defines
        // how much outside the groove the head of the handle extends
        property real halfPinWidth: handle.width / 4

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

        Item {
            id: content
            anchors.fill: parent

            property real handlePosition: handle.x
            function positionForValue(value) {
                return rangeModel.positionForValue(value);
            }
        }

        Item {
            anchors.fill: parent
            children: handle
            Binding {
                target: handle
                property: "x"
                value: shadowHandle.x - contents.halfHandleWidth
            }
        }

        Item {
            id: shadowHandle
            width: handle.width
            height: handle.height
            transform: Translate { x: -contents.halfHandleWidth }
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
    }

    property bool __ready: false
    Component.onCompleted: {
        // It's probably not enough
        __ready = true;
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
