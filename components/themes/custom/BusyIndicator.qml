import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.BusyIndicator {
    implicitWidth: wheel.width
    implicitHeight: wheel.height

    themeStyle {
        image: "images/spinner.png"
    }

    Image {
        id: wheel
        smooth: true
        source: style.image
        fillMode: Image.PreserveAspectFit

        property int steps: 12
        property int rotationStep: 0
        rotation: rotationStep * (360 / steps)

        NumberAnimation on rotationStep {
            running: widget.opacity > 0 &&
                     widget.visible && widget.running
            from: 0; to: wheel.steps;
            loops: Animation.Infinite; duration: 1000 // 1s per revolution
        }
    }
}
