import QtQuick 1.1
import "widgets"
import "../../components"
import "../../components/experimental"

Window {
    id: rootWindow
    width: 360
    height: 640

    Component {
        id: mainComponent
        MainPage { }
    }

    ThemePalette {
        id: activePalette
        colorGroup: "active"
    }

    PageNavigator {
        id: navigator
        anchors.fill: parent

        Component.onCompleted: {
            navigator.pushPage(mainComponent);
        }
    }
}
