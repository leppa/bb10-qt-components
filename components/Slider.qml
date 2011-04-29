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
import "./private"
import "./styles" 1.0

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

    property alias delegate: loader.delegate
    property SliderStyle style: SliderStyle {}

    // implementation
    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: slider
        property alias userStyle: slider.style
        property alias mouseArea: mouseArea
        property alias rangeModel: rangeModel
        filepath: Qt.resolvedUrl(theme.path + "Slider.qml");
    }

    RangeModel {
        id: rangeModel
        value: 0
        stepSize: 0
        inverted: false
        minimumValue: 0.0
        maximumValue: 1.0
        positionAtMinimum: mouseArea.halfPinWidth // relative to *center* of handle
        positionAtMaximum: loader.item.contentWidth - mouseArea.halfPinWidth
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        property Item handle: loader.item.handleItem
        // The width of the "pin" that the handle is attached to, defines
        // how much outside the groove the head of the handle extends
        property real halfPinWidth: loader.item.style.pinWidth / 2
        property real halfHandleWidth: mouseArea.handle.width / 2

        anchors.leftMargin: -halfHandleWidth
        anchors.rightMargin: -halfHandleWidth

        drag.target: mouseArea.handle
        drag.axis: Drag.XAxis
        drag.minimumX: rangeModel.positionAtMinimum
        drag.maximumX: rangeModel.positionAtMaximum

        onPressed: {
            // Compensate for mouse area being wider than the slider itself
            var newX = mouse.x - halfHandleWidth;

            // Debounce the press: a press event inside the handler should not
            // change its position, the user needs to drag it.
            if (Math.abs(newX - mouseArea.handle.x) > halfHandleWidth)
                rangeModel.position = newX;
        }

        onReleased: {
            // If we don't update while dragging, this is the only
            // moment that the rangeModel is updated.
            if (!slider.updateValueWhileDragging)
                rangeModel.position = mouseArea.handle.x;
        }
    }

    // rangeModel position normally follow handleItem, except when
    // 'updateValueWhileDragging' is false. In this case it will only follow
    // if the user is not pressing the handle.
    Binding {
        target: rangeModel
        property: "position"
        value: mouseArea.handle.x
        when: updateValueWhileDragging || !mouseArea.pressed
    }

    // During the drag, we simply ignore position set from the rangeModel, this
    // means that setting a value while dragging will not "interrupt" the
    // dragging activity.
    Binding {
        target: mouseArea.handle
        property: "x"
        value: rangeModel.position
        when: !mouseArea.drag.active
    }
}
