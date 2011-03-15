import QtQuick 1.1

QtObject {
    property color backgroundColor
    property color progressColor

    property Component background
    property Component progress
    property Component indeterminateProgress

    property int leftMargin
    property int topMargin
    property int rightMargin
    property int bottomMargin

    property int minimumWidth
    property int minimumHeight

    function horizontalMargins() { return leftMargin+rightMargin; }
    function verticalMargins() { return topMargin+bottomMargin; }
}
