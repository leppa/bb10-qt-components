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

QtObject {

    property Component background: Component {
        Item {
            id: background
            Rectangle { // solid center fill
                anchors.fill: parent
                anchors.margins: 1
                color: "white"
                radius: 5
            }
            BorderImage { // rounded border
                anchors.fill: parent
                source: "images/progressbar_groove.png"
                border { left: 10; right: 10; top: 10; bottom: 10 }
            }

            BorderImage { // top-to-bottom shine
                visible: !styledItem.indeterminate
                opacity: styledItem.enabled ? 1: 0.7
                source: complete > 0.95 ? "images/progressbar_indeterminate.png" : "images/progressbar_fill.png"
                border { left: complete > 0.1 ? 6: 2; right: complete > 0.1 ? 6: 2; top: 10; bottom: 10 }
                width: Math.round((progressBar.width-styling.horizontalMargins()) * complete)
                height: parent.height
                clip: true

                Rectangle { // background solid fill (behind diagonal stripes)
                    anchors.fill: parent
                    anchors.rightMargin: 0
                    anchors.margins: 1

                    z: -1
                    radius: 2
                    color: "orange"
                    smooth: true
                    clip: true
                    Image { // diagonal stripes
                        id: poverlay
                        NumberAnimation on x {
                            loops: Animation.Infinite
                            from: 0; to: -poverlay.sourceSize.width
                            duration: 2000
                        }
                        width: styledItem.width + sourceSize.width
                        height: styledItem.height
                        fillMode: Image.Tile
                        source: "images/progressbar_overlay.png"
                    }
                }
            }

            Item {
                id: bar
                visible: styledItem.indeterminate
                anchors.fill: parent
                SequentialAnimation { // Animated the puck bouncing back-and-fourth
                    id: bounceAnim
                    running: true; loops: Animation.Infinite
                    property int scaledDuration: Math.max(1000*(width/bar.width), 100); // for constant speed

                    property int bounceToValue: bar.width-puck.width
                    onBounceToValueChanged: { // work-arounds for QTBUG-17554 and QTBUG-17552
                        outAnim.to = bounceToValue;
                        inAnim.from = bounceToValue;
                        restart() // Restart the bounceAnim, or it won't take the new width into account!
                    }

                    NumberAnimation {   // animate the bouncing back and fourth
                        id: outAnim; target: puck; property: "x"
                        from: 0; to: bounceAnim.bounceToValue
                        easing.type: Easing.Linear; duration: bounceAnim.scaledDuration
                    }
                    NumberAnimation {   // animate the bouncing back and fourth
                        id: inAnim; target: puck; property: "x"
                        from: bounceAnim.bounceToValue; to: 0
                        easing.type: Easing.Linear; duration: bounceAnim.scaledDuration
                    }
                }

                BorderImage { // top-to-bottom shine
                    id: puck
                    width: Math.min(80, bar.width/2)
                    height: bar.height

                    opacity: styledItem.enabled ? 1: 0.7
                    source: "images/progressbar_indeterminate.png"
                    border { left: 10; right: 10; top: 10; bottom: 10 }
                    clip: true

                    Rectangle { // background solid fill (behind diagonal stripes)
                        anchors.fill: puck
                        anchors.margins: 1
                        anchors.rightMargin: 0

                        z: -1
                        radius: 2
                        color: "orange"
                        smooth: true
                        clip: true

                        Image { // diagonal stripes
                            id: overlay
                            width: styledItem.width + sourceSize.width
                            height: styledItem.height
                            NumberAnimation on x {  // animate stripes continously sliding left
                                loops: Animation.Infinite;
                                from: 0; to: -overlay.sourceSize.width;
                                duration: 2000
                            }
                            fillMode: Image.Tile
                            source: "images/progressbar_overlay.png"
                        }
                    }
                }
            }
        }
    }
}
