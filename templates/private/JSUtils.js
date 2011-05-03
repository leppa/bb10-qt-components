/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
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

// Function.bind() is already supported in JavaScript 1.8.5
// so this should not be needed at some point in the future.
if (typeof Function.prototype.bind !== "function")
    Function.prototype.bind = function() {
        var func = this;
        var thisObject = arguments[0];
        var args = Array.prototype.slice.call(arguments, 1);
        return function() {
            return func.apply(thisObject, args);
        };
    };

// For proper object prototype initialization
if (typeof Object.extend !== "function") {
    Object.extend = function(target, source) {
        for (var p in source)
            target[p] = source[p];
        return target;
    };

    Object.prototype.addMethods = function(methods) {
        return Object.extend(this.prototype, methods);
    };
}
