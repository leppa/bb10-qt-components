import QtQuick 1.1
import "../../../components" as Components
import com.meego.themebridge 1.0    // MaskedItem

Components.ProgressBar{

    // implementation

    minimumHeight: 8
    minimumWidth: 250

    background: Component {
        Item {
            BorderImage { // rounded border
                anchors.fill: parent
                source: "image://theme/meegotouch-progressindicator-bar-background"
                border { left: 6; right: 6; top: 4; bottom: 4 }
            }
        }
    }

    //mm Seems MaskedItem's clipping doesn't quite work. Defect?
    progress: Component {    // progress bar, known duration
        Item {
            id: bar
            opacity: styledItem.enabled ? 1: 0.7
            MaskedItem { //mm MaskedItem seems to get it's size from its mask. Defect?
                anchors.fill: parent
                mask: BorderImage {
                    width: bar.width; height: bar.height
                    source: "image://theme/meegotouch-progressindicator-bar-mask"
                    border { left: 4; top: 4; right: 4; bottom: 4 }
                }

                Image {
                    anchors.fill: parent
                    opacity: styledItem.enabled ? 1: 0.7
                    source: "image://theme/meegotouch-progressindicator-bar-known-texture"
                }
            }
        }

    }

    indeterminateProgress: Component {   // progress bar, unknown duration
        Item {
            id: bar
            opacity: styledItem.enabled ? 1: 0.7
            MaskedItem {
                anchors.fill: parent
                mask: BorderImage {
                    width: bar.width; height: bar.height
                    source: "image://theme/meegotouch-progressindicator-bar-mask"
                    border { left: 4; top: 4; right: 4; bottom: 4 }
                }

                Image {
                    width: parent.width+10
                    height: parent.height
                    opacity: styledItem.enabled ? 1: 0.7
                    fillMode: Image.Tile
                    source: "image://theme/meegotouch-progressindicator-bar-unknown-texture"

                    NumberAnimation on x {
                        running: true; loops: Animation.Infinite
                        from: -8; to: 0; duration: 200
                    }
                }
            }
        }
    }
}
