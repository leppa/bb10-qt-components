import QtQuick 1.1
import "widgets"
import "../../components"

Rectangle {
    width: 360
    height: 640
    color: "white"

    Component {
        id: mainComponent
        MainPage { }
    }

    PageNavigator {
        id: navigator
        anchors.fill: parent

        Component.onCompleted: {
            navigator.pushPage(mainComponent);
        }
    }
}
