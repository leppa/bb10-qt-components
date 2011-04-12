import QtQuick 1.1

QtObject {
    property color textColor

    property Component background
    property Component up
    property Component down

    property int minimumWidth
    property int minimumHeight

    property int leftMargin
    property int topMargin
    property int rightMargin
    property int bottomMargin

    function horizontalMargins() { return leftMargin+rightMargin; }
    function verticalMargins() { return topMargin+bottomMargin; }
}
