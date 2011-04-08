import QtQuick 1.1
import "../components"

Column {
    property alias value: sl.value

    SpinBox {
        id: sb
        minimumValue: 0
        maximumValue: 255
    }
    Slider {
        id: sl
        minimumValue: 0
        maximumValue: 255
        stepSize: 1
        onValueChanged: sb.setValue(value)
    }
    Binding {
        target: sl
        property: "value"
        value: sb.value
    }
}
