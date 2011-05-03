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

// XXX: this is a placeholder until we get .import in QML 2.0
Qt.include("ExclusiveGroup.js")

/// Helper code that is shared between ButtonRow.qml and ButtonColumn.qml.

var self = undefined;
var exclusiveGroup = null;
var buttons = [];
var firstVisible = -1;
var lastVisible = -1;
var visibleButtons = 0;
var params = undefined;

// Platform -> Button
function isButton(item) {
    return (item && item.hasOwnProperty("__position"));
}

function hasChecked(item) {
    return (item && item.hasOwnProperty("checked")) || ("checked" in item);
}

function cleanup() {
    buttons.forEach(function(button, i) {
        if (button.visible && params.exclusive)
            exclusiveGroup.disconnectCheckedChanged(button, i)
        if (isButton(button))
            button.visibleChanged.disconnect(buttonVisibleChanged);
    });
    buttons = [];
    if (exclusiveGroup)
        exclusiveGroup.clear();
}

function updateButtons() {
    cleanup();

    params.exclusive = self.exclusive;

    var checkedButton = null;
    var length = self.children.length;
    for (var i = 0; i < length; i++) {
        var item = self.children[i];
        if (!hasChecked(item))
            continue;
        buttons.push(item);

        item.visibleChanged.connect(buttonVisibleChanged);

        // Platform -> ButtonRow/ButtonColumn
        if (item.checked) {
            if (!checkedButton && (self.checkedButton === item || self.checkedButton == undefined))
                checkedButton = item;
            else if (params.exclusive && self.checkedButton != item)
                item.checked = false;
        } else if (self.checkedButton === item) {
            if (checkedButton && params.exclusive)
                checkedButton.checked = false;
            checkedButton = item;
            item.checked = true;
        }

        if (typeof params.prepareItem === "function")
            params.prepareItem(item);

        if (params.exclusive)
            exclusiveGroup.connectCheckedChanged(item);
    }
    self.checkedButton = checkedButton;

    buttonVisibleChanged();
}

function buttonVisibleChanged() {
    visibleButtons = 0;
    firstVisible = -1;
    lastVisible = -1;
    buttons.forEach(function (button, i) {
        if (button.visible) {
            if (firstVisible === -1)
                firstVisible = i;
            lastVisible = i;
            visibleButtons++;
        }
    });

    if (visibleButtons === 0 || typeof params.setPosition !== "function")
        return;

    if (visibleButtons == 1) {
        params.setPosition(buttons[0], "single")
    } else {
        params.setPosition(buttons[firstVisible], "first");
        for (var i = firstVisible + 1; i < lastVisible; i++)
            params.setPosition(buttons[i], "middle");
        params.setPosition(buttons[lastVisible], "last");
    }

    resizeChildren();
}

var resizing = false;  // resizeChildren() may trigger reentrant calls

function resizeChildren() {
    if (resizing || visibleButtons === 0)
        return;

    if (typeof params.resizeChildren === "function") {
        resizing = true;
        params.resizeChildren(self);
        resizing = false;
    }
}

function notifyExclusiveGroup() {
    if (exclusiveGroup)
        exclusiveGroup.updateCheckedObj(self.checkedButton);
}

function create(s, p) {
    if (!s) {
        console.log("Error creating ButtonGroup: invalid owner.");
        return;
    }
    if (!s.hasOwnProperty("checkedButton")) {
        console.log("Error creating ButtonGroup: owner has no 'checkedButton' property.");
        return;
    }

    self = s;
    params = p;

    exclusiveGroup = new ExclusiveGroup(self.checkedButton, params.exclusive,
                                        function() { self.checkedButton = this.checkedObj; });
    self.checkedButtonChanged.connect(notifyExclusiveGroup);

    updateButtons();
    self.childrenChanged.connect(updateButtons);
    self.exclusiveChanged.connect(updateButtons);
    self.widthChanged.connect(resizeChildren);
}

function destroy() {
    if (self) {
        self.checkedButtonChanged.disconnect(notifyExclusiveGroup);
        self.childrenChanged.disconnect(updateButtons);
        self.widthChanged.disconnect(resizeChildren);
        self = undefined;
    }
    cleanup();
}

