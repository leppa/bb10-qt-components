import QtQuick 1.1
import QtLabs.components.themes.template 1.0 as Template

Template.ScrollDecorator {
    themeStyle {
        borderMargin: 2
        minimumSize: 4
    }

    content: Component {
        Rectangle {
            anchors.margins: 3
            color: "gray"
            border.color: "black"
            radius: 2
            opacity: 0.7
        }
    }
}
