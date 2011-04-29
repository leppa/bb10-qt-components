import QtQuick 1.1
import "./private"
import "./styles" 1.0
import "./behaviors" 1.0

Item {
    id: radioButton

    signal clicked
    property alias pressed: behavior.pressed
    property alias checked: behavior.checked
    property alias containsMouse: behavior.containsMouse

    property alias delegate: loader.delegate
    property RadioButtonStyle style: RadioButtonStyle {}

    DualLoader {
        id: loader
        anchors.fill: parent
        property alias widget: radioButton
        property alias userStyle: radioButton.style
        filepath: Qt.resolvedUrl(theme.path + "RadioButton.qml")
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        checkable: true
        onClicked: radioButton.clicked()
    }

    implicitWidth: loader.item.implicitWidth
    implicitHeight: loader.item.implicitHeight
}
