import QtQuick 1.1
import "./styles"       // ProgressBarStylingProperties
import "./styles/default" as DefaultStyles

Item {
    id: progressBar

    property real value: rangeModel.value
    property alias minimumValue: rangeModel.minimumValue
    property alias maximumValue: rangeModel.maximumValue
    property bool indeterminate: false
    default property alias data: content.data

    property ProgressBarStylingProperties styling: ProgressBarStylingProperties {
        background: defaultStyle.background
    }

    // implementation

    implicitWidth: 200
    implicitHeight: 30

    RangeModel {
        id: rangeModel
        minimumValue: 0.0
        maximumValue: 1.0
        value: 0
        stepSize: 0
        inverted: false
    }

    property real complete: (progressBar.value-progressBar.minimumValue)/(progressBar.maximumValue-progressBar.minimumValue)

    Item {
        id: content
        anchors.fill:parent
        property alias styledItem: progressBar
    }

/*    Loader {
        // groove background
        id: grooveLoader
        sourceComponent: styling.background
        anchors.fill: parent
    }
*/
    DefaultStyles.ProgressBarStyle { id: defaultStyle }

    Binding {
        property: "value"
        target: rangeModel
        value: progressBar.value
    }
}
