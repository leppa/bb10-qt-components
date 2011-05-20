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
    name: "ProgressBar"

    SpecProgressBar {
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

    function test_indeterminate() {
        var message =
            "Checking if indeterminate can be set and verified.";
        obj.indeterminate = true;
        compare(obj.indeterminate, true, message);
        obj.indeterminate = false;
        compare(obj.indeterminate, false, message);

        var message =
            "Indeterminate state should not change value property.";
        obj.value = 0;
        obj.indeterminate = true;
        wait(10);
        compare(obj.value, 0, message);
    }
}
