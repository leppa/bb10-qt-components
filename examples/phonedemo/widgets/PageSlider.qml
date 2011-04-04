import QtQuick 1.1
import "PageSlider.js" as Core

Item {
    id: pageSlider
    property int pageCount : 0
    property Page currentPage
    property bool animating : slideAnimation.running

    clip: true

    Flickable {
        id: flickable
        interactive: false
        anchors.fill: parent
        contentWidth: content.width
        contentHeight: content.height

        Row {
            id: content
        }

        Behavior on contentX {
            SequentialAnimation {
                id: slideAnimation
                NumberAnimation {
                    duration: 500
                    easing.type: Easing.InOutQuart
                }
                ScriptAction {
                    script: Core.finalize();
                }
            }
        }
    }

    Component {
        id: pageContainer
        Item {
            property Page page
            width: flickable.width
            height: flickable.height

            Connections {
                target: page
                onNext: {
                    var component = Qt.createComponent(filename);

                    if (component.status == Component.Ready)
                        pageSlider.pushPage(component);
                    else
                        console.log(component.errorString());
                }
                onBack: pageSlider.popPage();
            }
        }
    }

    function pushPage(component) {
        return Core.push(component);
    }

    function popPage() {
        return Core.pop();
    }
}
