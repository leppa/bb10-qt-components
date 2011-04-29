import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.ScrollDecorator {
    themeStyle {
        minimumSize: 6
        borderMargin: 2
    }

    content: Component {
        Rectangle {
            opacity: 0.7
            color: "black"
            border.color: "white"
            anchors.margins: 3
        }
    }
}
