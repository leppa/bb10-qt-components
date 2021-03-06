/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1 as QtComponents

Item {
    id: root

    property alias maximumValue: model.maximumValue
    property alias ratingValue: model.value
    property int count: -1
    property bool platformInverted: false

    implicitHeight: Math.max(background.height, text.paintedHeight);
    implicitWidth: background.width + (count >= 0 ? internal.textSpacing + text.paintedWidth : 0);

    QtComponents.RangeModel {
        id: model
        value: 0.0
        minimumValue: 0.0
        maximumValue: 0.0
    }

    QtObject {
        id: internal

        // spacing between image and text
        property int textSpacing: platformStyle.paddingMedium
        property string textColor: root.platformInverted ? platformStyle.colorNormalLightInverted
                                                         : platformStyle.colorNormalLight

        property string backgroundImageSource: "qtg_graf_rating_unrated"
        property string indicatorImageSource: "qtg_graf_rating_rated"
    }

    Row {
        id: background
        anchors.verticalCenter: height < text.paintedHeight ? text.verticalCenter : undefined
        spacing: platformStyle.paddingMedium
        Repeater {
            model: maximumValue
            Image {
                id: backgroundImage
                source: privateStyle.imagePath(internal.backgroundImageSource, root.platformInverted)
                sourceSize.width: platformStyle.graphicSizeTiny
                sourceSize.height: platformStyle.graphicSizeTiny
            }
        }
    }

    Row {
        id: indicator
        anchors.verticalCenter: height < text.paintedHeight ? text.verticalCenter : undefined
        spacing: platformStyle.paddingMedium
        Repeater {
            model: ratingValue
            Image {
                id: indicatorImage
                source: privateStyle.imagePath(internal.indicatorImageSource, root.platformInverted)
                sourceSize.width: platformStyle.graphicSizeTiny
                sourceSize.height: platformStyle.graphicSizeTiny
            }
        }
    }

    Text {
        id: text
        visible: count >= 0
        text: "(" + count + ")"
        color: internal.textColor
        font { family: platformStyle.fontFamilyRegular; pixelSize: platformStyle.fontSizeSmall }
        anchors.left: background.right
        anchors.leftMargin: internal.textSpacing
    }
}
