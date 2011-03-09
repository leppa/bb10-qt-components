/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components API Conformance Test Suite.
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

import QtQuick 1.0
import QtQuickTest 1.0

ComponentTestCase {
    name: "Slider"

    SpecSlider {
        id: testSubject
    }

    function test_minimumValue() {}
    function test_maximumValue() {}
    function test_value() {
        var message =
            "When setting a value over the maximum limit, the value should be set to the " +
            "maximum limit.";
        obj.value = 2.0;
        compare(obj.value, obj.maximumValue, message);

        var message =
            "When setting a value under the minimum limit, the value should be set to the " +
            "minimum limit.";
        obj.value = -2.0;
        compare(obj.value, obj.minimumValue, message);

        var message =
            "maximumValue should observe the current value and adjust when necessary.";
        obj.value = 0.8;
        obj.maximumValue = 0.5;
        compare(obj.value, 0.5, message);

        var message =
            "minimumValue should observe the current value and adjust when necessary.";
        obj.value = 0.1;
        obj.minimumValue = 0.2;
        compare(obj.value, 0.2, message);

        var message =
            "maximumValue can't never be lower than minimumValue.";
        obj.minimumValue = 0.4;
        obj.maximumValue = 0.2;
        compare(obj.maximumValue, 0.2, message);
        compare(obj.minimumValue, 0.2, message);
        compare(obj.value, 0.2, message);

        var message =
            "minimumValue can't never be greater than maximumValue.";
        obj.maximumValue = 1.0;
        obj.minimumValue = 2.0;
        compare(obj.maximumValue, 2.0, message);
        compare(obj.minimumValue, 2.0, message);
        compare(obj.value, 2.0, message);
    }

    function test_stepSize() {
        var message =
            "stepSize zero should accept any kind of integer and floating values between range.";
        obj.minimumValue = 0;
        obj.maximumValue = 100;
        obj.stepSize = 0;
        obj.value = 42.12345;
        compare(obj.value, 42.12345, message);
        obj.value = 42.99999;
        compare(obj.value, 42.99999, message);
        obj.value = 42;
        compare(obj.value, 42, message);

        var message =
            "stepSize and value should use half down rounding.";
        obj.stepSize = 10;
        obj.value = 5.0001;
        compare(obj.value, 10, message);
        obj.value = 5;
        compare(obj.value, 0, message);

        var message =
            "Checking if rounding is respecting the upper limits.";
        obj.stepSize = 15;
        obj.value = 99;
        compare(obj.value, 100, message);
    }

    function test_pressed() {
        var message =
            "Pressing and releasing the mouse must change pressed property.";
        mousePress(obj, obj.width / 2, obj.height / 2);
        compare(obj.pressed, true, message);
        mouseRelease(obj, obj.width / 2, obj.height / 2);
        compare(obj.pressed, false, message);
    }

    function test_orientation() {
        var message =
            "Checking whenever orientation is settable and verifiable.";
        obj.orientation = Qt.Vertical
        compare(obj.orientation, Qt.Vertical, message);
        obj.orientation = Qt.Horizontal
        compare(obj.orientation, Qt.Horizontal, message);
    }

    SignalSpy {
        id: spy
        signalName: "valueChanged"
    }

    function test_updateValueWhileDragging() {
        spy.target = obj;

        // XXX: We are assuming here that the "handle" sits on the
        // middle of the slider when at 50%, but this might depends
        // on theming.
        var message =
            "Dragging with updateValueWhileDragging set to true should update value " + 
            "property for each main loop iteration during the drag.";
        obj.updateValueWhileDragging = true;
        mousePress(obj, obj.width / 2, obj.height / 2);
        spy.clear();
        wait(0);
        mouseMove(obj, obj.width / 3, obj.height / 2);
        wait(0);
        mouseMove(obj, obj.width / 4, obj.height / 2);
        wait(0);
        mouseMove(obj, obj.width / 5, obj.height / 2);
        wait(0);
        mouseRelease(obj, obj.width / 5, obj.height / 2);
        expectFail("", message + " Fails because of QTBUG-13397.");
        compare(spy.count, 3, message);

        var message =
            "Dragging with updateValueWhileDragging set to false should update value " +
            "only when the mouse is release.";
        obj.updateValueWhileDragging = false;
        mousePress(obj, obj.width / 2, obj.height / 2);
        spy.clear();
        wait(0);
        mouseMove(obj, obj.width / 3, obj.height / 2);
        wait(0);
        mouseMove(obj, obj.width / 4, obj.height / 2);
        wait(0);
        mouseMove(obj, obj.width / 5, obj.height / 2);
        wait(0);
        mouseRelease(obj, obj.width / 5, obj.height / 2);
        expectFail("", message + " Fails because of QTBUG-13397.");
        compare(spy.count, 1, message);
    }
}
