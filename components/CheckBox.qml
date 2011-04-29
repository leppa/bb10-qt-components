import QtQuick 1.1
import "./private"
import "./styles" 1.0
import "./behaviors" 1.0

Item {
    id: checkBox

    signal clicked
    property alias pressed: behavior.pressed
    property alias checked: behavior.checked
    property alias containsMouse: behavior.containsMouse

    property alias delegate: loader.delegate
    property CheckBoxStyle style: CheckBoxStyle {}

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: checkBox
        property alias userStyle: checkBox.style
        filepath: Qt.resolvedUrl(theme.path + "CheckBox.qml")
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        checkable: true
        onClicked: checkBox.clicked()
    }

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight
}
