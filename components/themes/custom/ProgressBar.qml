import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.ProgressBar {
    themeStyle {
        backgroundColor: "white"
        progressColor: "blue"
        minimumWidth: 200
        minimumHeight: 25
    }

    Item {
        anchors.fill: parent

        Rectangle { // solid center fill
            anchors.fill: parent
            anchors.margins: 1
            color: style.backgroundColor
            radius: 5
        }
        BorderImage { // rounded border
            anchors.fill: parent
            source: "images/progressbar_groove.png"
            border { left: 10; right: 10; top: 10; bottom: 10 }
        }
    }

    // progressbar
    BorderImage {
        visible: !widget.indeterminate
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
        width: Math.round((widget.width - style.leftMargin - style.rightMargin) * complete)

        opacity: widget.enabled ? 1: 0.7
        source: complete > 0.95 ? "images/progressbar_indeterminate.png" : "images/progressbar_fill.png"
        border { left: complete > 0.1 ? 6: 2; right: complete > 0.1 ? 6: 2; top: 10; bottom: 10 }
        clip: true

        Rectangle { // background solid fill (behind diagonal stripes)
            anchors.fill: parent
            anchors.rightMargin: 0
            anchors.margins: 1

            z: -1
            radius: 2
            color: style.progressColor
            smooth: true
            clip: true
            Image { // diagonal stripes
                id: overlay1
                NumberAnimation on x {
                    loops: Animation.Infinite
                    from: 0; to: -overlay1.sourceSize.width
                    duration: 2000
                }
                width: widget.width + sourceSize.width
                height: widget.height
                fillMode: Image.Tile
                source: "images/progressbar_overlay.png"
            }
        }
    }

    Item {
        // indeterminate
        id: bar1
        anchors.fill: parent
        visible: widget.indeterminate

        SequentialAnimation { // Animated the puck bouncing back-and-fourth
            id: bounceAnim
            running: true; loops: Animation.Infinite
            property int scaledDuration: Math.max(1000*(width/style.minimumWidth), 100); // for constant speed

            property int bounceToValue: bar1.width-puck.width
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

            width: Math.min(80, bar1.width/2)
            height: bar1.height

            opacity: widget.enabled ? 1: 0.7
            source: "images/progressbar_indeterminate.png"
            border { left: 10; right: 10; top: 10; bottom: 10 }
            clip: true

            Rectangle { // background solid fill (behind diagonal stripes)
                anchors.fill: puck
                anchors.margins: 1
                anchors.rightMargin: 0

                z: -1
                radius: 2
                color: style.progressColor
                smooth: true
                clip: true

                Image { // diagonal stripes
                    id: overlay2
                    width: widget.width + sourceSize.width
                    height: widget.height
                    NumberAnimation on x {  // animate stripes continously sliding left
                        loops: Animation.Infinite;
                        from: 0; to: -overlay2.sourceSize.width;
                        duration: 2000
                    }
                    fillMode: Image.Tile
                    source: "images/progressbar_overlay.png"
                }
            }
        }
    }
}
