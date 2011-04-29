import QtQuick 1.1
import "./private"
import "./styles" 1.0

Item {
    id: progressBar

    property alias value: rangeModel.value
    property alias minimumValue: rangeModel.minimumValue
    property alias maximumValue: rangeModel.maximumValue
    property bool indeterminate: false

    property alias delegate: loader.delegate
    property ProgressBarStyle style: ProgressBarStyle { }

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: progressBar
        property alias userStyle: progressBar.style
        property real complete: (value - minimumValue) / (maximumValue - minimumValue)
        filepath: Qt.resolvedUrl(theme.path + "ProgressBar.qml")
    }

    RangeModel {
        id: rangeModel
        value: 0
        stepSize: 0
        inverted: false
        minimumValue: 0.0
        maximumValue: 1.0
    }

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight
}
