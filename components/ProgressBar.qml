import QtQuick 1.1
import "./styles"       // ProgressBarStylingProperties
import "./styles/default" as DefaultStyles

Item {
    id: progressBar

    property alias value: rangeModel.value
    property alias minimumValue: rangeModel.minimumValue
    property alias maximumValue: rangeModel.maximumValue
    property bool indeterminate: false

    property ProgressBarStylingProperties styling: ProgressBarStylingProperties {
        backgroundColor: syspal.base
        progressColor: syspal.highlight

        background: defaultStyle.background
        progress: defaultStyle.progress
        indeterminateProgress: defaultStyle.indeterminateProgress

        leftMargin: defaultStyle.leftMargin
        topMargin: defaultStyle.topMargin
        rightMargin: defaultStyle.rightMargin
        bottomMargin: defaultStyle.bottomMargin

        minimumWidth: defaultStyle.minimumWidth
        minimumHeight: defaultStyle.minimumHeight
    }

    // implementation

    implicitWidth: Math.max(styling.minimumWidth, grooveLoader.item.implicitWidth) + styling.horizontalMargins()
    implicitHeight: Math.max(styling.minimumHeight, grooveLoader.item.implicitHeight) + styling.verticalMargins()

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
        sourceComponent: styling.background
        anchors.fill: parent
    }

    Item {
        anchors {
            fill: parent
            leftMargin: styling.leftMargin; rightMargin: styling.rightMargin;
            topMargin: styling.topMargin; bottomMargin: styling.bottomMargin
        }

        Loader { // regular progress bar
            anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
            width: Math.round((progressBar.width-styling.horizontalMargins()) * complete)

            property alias styledItem: progressBar
            property real complete: (value-minimumValue)/(maximumValue-minimumValue)
            sourceComponent: !indeterminate ? styling.progress : undefined
        }

        Loader { // bar for indeterminate progress
            anchors.fill: parent
            property alias styledItem: progressBar
            sourceComponent: indeterminate ? styling.indeterminateProgress : undefined
        }
    }

    DefaultStyles.ProgressBarStyle { id: defaultStyle }

    SystemPalette { id: syspal }
}
