import QtQuick 1.1
import "./behaviors"
import "./styles"      // CheckBoxStylingProperties

Item {
    id: checkBox

    signal clicked
    property alias pressed: behavior.pressed
    property alias checked: behavior.checked
    property alias containsMouse: behavior.containsMouse
    default property alias data: content.data

    implicitWidth: 32
    implicitHeight: 32

    Item {
        id: content
        anchors.fill: parent
    }

    ButtonBehavior {
        id: behavior
        anchors.fill: parent
        checkable: true
        onClicked: checkBox.clicked()
    }
}
