import QtQuick 1.1
import Qt.labs.components 1.0 // RangeModel
import "./styles/default" as DefaultStyles

Item {
    id: progressBar

    property alias value: rangeModel.value
    property alias minimumValue: rangeModel.minimumValue
    property alias maximumValue: rangeModel.maximumValue
    property bool indeterminate: false

    property color backgroundColor: syspal.base
    property color progressColor: syspal.highlight

    property Component background: defaultStyle.background
    property Component progress: defaultStyle.progress
    property Component indeterminateProgress: defaultStyle.indeterminateProgress

    property int leftMargin: defaultStyle.leftMargin
    property int topMargin: defaultStyle.topMargin
    property int rightMargin: defaultStyle.rightMargin
    property int bottomMargin: defaultStyle.bottomMargin

    property int minimumWidth: defaultStyle.minimumWidth
    property int minimumHeight: defaultStyle.minimumHeight

    // implementation

    implicitWidth: Math.max(minimumWidth, grooveLoader.item.implicitWidth) + leftMargin + rightMargin
    implicitHeight: Math.max(minimumHeight, grooveLoader.item.implicitHeight) + topMargin + bottomMargin

    RangeModel {
        id: rangeModel
        minimumValue: 0.0
        maximumValue: 1.0
        value: 0
        stepSize: 0
        inverted: false
    }

    Loader { // groove background
        id: grooveLoader
        property alias styledItem: progressBar
        sourceComponent: background
        anchors.fill: parent
    }

    Item {
        anchors {
            fill: parent
            leftMargin: leftMargin; rightMargin: rightMargin;
            topMargin: topMargin; bottomMargin: bottomMargin
        }

        Loader { // regular progress bar
            anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
            width: Math.round((progressBar.width-leftMargin-rightMargin) * complete)

            property alias styledItem: progressBar
            property real complete: (value-minimumValue)/(maximumValue-minimumValue)
            sourceComponent: !indeterminate ? progressBar.progress : undefined
        }

        Loader { // bar for indeterminate progress
            anchors.fill: parent
            property alias styledItem: progressBar
            sourceComponent: indeterminate ? indeterminateProgress : undefined
        }
    }

    DefaultStyles.ProgressBarStyle { id: defaultStyle }
    SystemPalette { id: syspal }
}
