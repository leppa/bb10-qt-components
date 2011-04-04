import QtQuick 1.1
import "../../../components/styles"

ButtonStylingProperties {
    id: customStyle

    property url source

    label: Component {
        Item { }
    }

    background: Component {
        Item {
            Image {
                id: image
                source: customStyle.source
                onWidthChanged: styledItem.width = width
                onHeightChanged: styledItem.height = height
            }
        }
    }
}
