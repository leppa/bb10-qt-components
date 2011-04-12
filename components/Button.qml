import QtQuick 1.1
import "./styles"     // ButtonStylingProperties
import "./styles/default" as DefaultStyles

BasicButton {
    id: button

    property string text
    property url iconSource

    property ButtonStylingProperties styling: ButtonStylingProperties {
        textColor: "black"

        background: defaultStyle.background
        label: defaultStyle.label

        leftMargin: defaultStyle.leftMargin
        topMargin: defaultStyle.topMargin
        rightMargin: defaultStyle.rightMargin
        bottomMargin: defaultStyle.bottomMargin

        minimumWidth: defaultStyle.minimumWidth
        minimumHeight: defaultStyle.minimumHeight
    }

    // implementation

    implicitWidth: Math.max(styling.minimumWidth, labelLoader.item.implicitWidth + styling.horizontalMargins())
    implicitHeight: Math.max(styling.minimumHeight, labelLoader.item.implicitHeight + styling.verticalMargins())

    Loader {
        id: labelLoader
        anchors.fill: parent
        anchors.leftMargin: styling.leftMargin
        anchors.rightMargin: styling.rightMargin
        anchors.topMargin: styling.topMargin
        anchors.bottomMargin: styling.bottomMargin
        property alias styledItem: button
        sourceComponent: styling.label
    }

    DefaultStyles.ButtonStyle { id: defaultStyle }
}
