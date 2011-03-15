import QtQuick 1.1

QtObject {
    property color textColor: syspal.text
    property color backgroundColor: syspal.button //mm No way to style this e.g. when color should be syspal.base

    property Component background: defaultStyle.background
    property Component label: defaultStyle.label
    property Component listItem: defaultStyle.listItem
    property Component popupFrame: defaultStyle.popupFrame

    property int minimumWidth: defaultStyle.minimumWidth
    property int minimumHeight: defaultStyle.minimumHeight

    property int leftMargin: defaultStyle.leftMargin
    property int topMargin: defaultStyle.topMargin
    property int rightMargin: defaultStyle.rightMargin
    property int bottomMargin: defaultStyle.bottomMargin

    function horizontalMargins() { return leftMargin+rightMargin; }
    function verticalMargins() { return topMargin+bottomMargin; }
}
