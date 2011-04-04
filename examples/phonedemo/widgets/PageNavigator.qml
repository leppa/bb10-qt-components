import QtQuick 1.1
import "../../../components"

Item {
    id: navigator

    function pushPage(component) {
        return slider.pushPage(component);
    }

    function popPage() {
        return slider.popPage();
    }

    PageSlider {
        id: slider
        anchors.fill: parent
        anchors.topMargin: 60

        onCurrentPageChanged: {
            if (currentPage != null) {
                menuLoader.sourceComponent = currentPage.menuDelegate;
            }
        }
    }

    Rectangle {
        id: topBar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        height: 60
        color: "#222222"

        Loader {
            id: menuLoader
            anchors.fill: parent
        }

        BorderImage {
            border.left: 10
            border.right: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.bottom
            source: "../images/shadow_bottom.png"
        }
    }
}
