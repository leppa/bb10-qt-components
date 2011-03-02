import QtQuick 1.1
import "./styles/default" as DefaultStyles
import "./private" as Private //  for ChoiceListPopup

// KNOWN ISSUES
// 1) Popout list does not have a scrollbar/scroll indicator or similar
// 2) The ChoiceListPopup should be dynamically loaded, to support radically different implementations
// 3) Mouse wheel scroll events not handled by the popout ListView (see QTBUG-7369)
// 4) Support for configurable bindings between model's and ChoiceList's properties similar to ButtonBlock's is missing

Item {
    id: choiceList

    property alias model: popup.model
    property int currentIndex: popup.currentIndex

    property alias containsMouse: mouseArea.containsMouse   //mm needed?
    property bool pressed: false    //mm needed?

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

    // Implementation

    implicitWidth: Math.max(minimumWidth,
                    labelLoader.item.implicitWidth + leftMargin + rightMargin)
    implicitHeight: Math.max(minimumHeight,
                     labelLoader.item.implicitHeight + topMargin + bottomMargin)

    Loader {
        anchors.fill: parent
        property alias styledItem: choiceList
        sourceComponent: background
    }

    Loader {
        id: labelLoader
        anchors {
            fill: parent
            leftMargin: leftMargin; rightMargin: rightMargin
            topMargin: topMargin; bottomMargin: bottomMargin
        }
        property alias styledItem: choiceList
        sourceComponent: label
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        drag.target: Item {}    // disable dragging in case ChoiceList is on a Flickable
        onPressed: {
            choiceList.pressed = true;
            popup.togglePopup();
        }
        onReleased: choiceList.pressed = false
        onCanceled: choiceList.pressed = false    // mouse stolen e.g. by Flickable
    }

    Private.ChoiceListPopup {
        id: popup
        listItem: choiceList.listItem
        popupFrame: choiceList.popupFrame
    }

    SystemPalette { id: syspal }
    DefaultStyles.ChoiceListStyle { id: defaultStyle }
}
