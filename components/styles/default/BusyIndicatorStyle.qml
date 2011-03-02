import QtQuick 1.1

QtObject {
    property Component background: Component {
        Image {
            source: "images/spinner.png";
            fillMode: Image.PreserveAspectFit
            smooth: true

            property int steps: 12
            property int rotationStep: 0
            rotation: rotationStep*(360/steps)
            NumberAnimation on rotationStep {
                running: busyIndicator.running; from: 0; to: steps;
                loops: Animation.Infinite; duration: 1000 // 1s per revolution
            }
        }
    }
}
