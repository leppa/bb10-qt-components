import QtQuick 1.1

QtObject {
    property color progressColor
    property color backgroundColor

    property Component groove
    property Component handle
    property Component valueIndicator

    property real pinWidth

    property int minimumWidth
    property int minimumHeight
}
