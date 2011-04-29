import QtQuick 1.1
import QtLabs.components.styles 1.0

Item {
    property BusyIndicatorStyle style: BusyIndicatorStyle {
        image: userStyle.image != "" ?
            userStyle.image : themeStyle.image
    }

    property BusyIndicatorStyle themeStyle: BusyIndicatorStyle {}
}
