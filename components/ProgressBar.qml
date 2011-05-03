import QtQuick 1.1
import "../templates"
import "./styles/default"

ProgressBar {
    id: progressBar

    //implicitWidth: loader.item.implicitWidth

    ProgressBarStyle {
        id: style
    }

    Loader {
        id: loader
        sourceComponent: style.background
        anchors.fill: parent
        property alias styledItem: progressBar
        property alias styling: style
    }
}
