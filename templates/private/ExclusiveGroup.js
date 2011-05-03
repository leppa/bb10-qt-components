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

Qt.include("JSUtils.js")

function ExclusiveGroup(checkedObj, exclusive, checkedObjChanged) {
    this.exclusive = exclusive; // TODO Remove this?
    this.checkedObjChanged = checkedObjChanged;

    this.checkedObj = checkedObj;
    this.prevCheckedObj = null;
    this.blockCheckedChanged = false;
    this.checkedChangedHandlers = [];
}

ExclusiveGroup.addMethods({
updateCheckedObj: function(o) {
    if (this.checkedObj === o)
        return;
    this.checkedObj = o;
    if (this.prevCheckedObj === this.checkedObj)
        return;
    this.blockCheckedChanged = true;
    if (this.exclusive && this.prevCheckedObj)
        this.prevCheckedObj.checked = false;
    if (this.checkedObj)
        this.checkedObj.checked = true;
    this.blockCheckedChanged = false;
    this.prevCheckedObj = this.checkedObj;
},

connectCheckedChanged: function(o) {
    var last = this.checkedChangedHandlers.push(this.checkExclusive(o));
    o.checkedChanged.connect(this.checkedChangedHandlers[last - 1]);
},

disconnectCheckedChanged: function(o, i) {
    if (this.checkedChangedHandlers[i]) {
        o.checkedChanged.disconnect(this.checkedChangedHandlers[i]);
        this.checkedChangedHandlers[i] = null;
    }
},

clear: function() {
    this.checkedChangedHandlers = [];
},

checkExclusive: function(o) {
    return function() {
        if (this.blockCheckedChanged)
            return;
        if (!o.checked) {
            if (this.checkedObj === o) {
                this.blockCheckedChanged = true;
                o.checked = true;
                this.blockCheckedChanged = false;
            }
            return;
        }
        if (this.checkedObj === o)
            return;
        if (this.checkedObj) {
            this.blockCheckedChanged = true;
            this.checkedObj.checked = false;
            this.blockCheckedChanged = false;
        }
        this.prevCheckedObj = o;
        this.checkedObj = o;
        this.checkedObjChanged();
    }.bind(this)
}
}); // ExclusiveGroup
