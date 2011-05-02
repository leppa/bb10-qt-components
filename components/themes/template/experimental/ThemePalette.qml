import QtQuick 1.1
import QtLabs.components.experimental 1.0

Item {
    id: palette

    property QtObject group: (colorGroup == "inactive") ? inactiveGroup
        : (colorGroup == "disabled") ? disabledGroup : activeGroup

    property ThemeGroup activeGroup: ThemeGroup {}
    property ThemeGroup inactiveGroup: ThemeGroup {}
    property ThemeGroup disabledGroup: ThemeGroup {}
}
