import QtQuick 1.1

QtObject {
    property color textColor

    property Component background
    property Component label

    property int leftMargin
    property int topMargin
    property int rightMargin
    property int bottomMargin

    property int minimumWidth
    property int minimumHeight

    function horizontalMargins() { return leftMargin+rightMargin; }
    function verticalMargins() { return topMargin+bottomMargin; }
}
