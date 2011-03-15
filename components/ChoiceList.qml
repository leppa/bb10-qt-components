import QtQuick 1.1
import "./styles"             // ChoiceListStylingProperties
import "./styles/default" as DefaultStyles
import "./private" as Private //  for ChoiceListPopup

// KNOWN ISSUES
// 1) Popout list does not have a scrollbar/scroll indicator or similar
// 2) The ChoiceListPopup should be dynamically loaded, to support radically different implementations
// 3) Mouse wheel scroll events not handled by the popout ListView (see QTBUG-7369)
// 4) Support for configurable bindings between model's and ChoiceList's properties is missing

Item {
    id: choiceList

    property alias model: popup.model
    property int currentIndex: popup.currentIndex

    property alias containsMouse: mouseArea.containsMouse   //mm needed?
    property bool pressed: false    //mm needed?

    property ChoiceListStylingProperties styling: ChoiceListStylingProperties {
        textColor: syspal.text
        backgroundColor: syspal.button //mm No way to style this e.g. when color should be syspal.base

        background: defaultStyle.background
        label: defaultStyle.label
        listItem: defaultStyle.listItem
        popupFrame: defaultStyle.popupFrame

        minimumWidth: defaultStyle.minimumWidth
        minimumHeight: defaultStyle.minimumHeight

        leftMargin: defaultStyle.leftMargin
        topMargin: defaultStyle.topMargin
        rightMargin: defaultStyle.rightMargin
        bottomMargin: defaultStyle.bottomMargin
    }

    // Implementation

    implicitWidth: Math.max(styling.minimumWidth,
                    labelLoader.item.implicitWidth + styling.horizontalMargins())
    implicitHeight: Math.max(styling.minimumHeight,
                     labelLoader.item.implicitHeight + styling.verticalMargins())

    Loader {
        anchors.fill: parent
        property alias styledItem: choiceList
        sourceComponent: styling.background
    }

    Loader {
        id: labelLoader
        anchors {
            fill: parent
            leftMargin: styling.leftMargin; rightMargin: styling.rightMargin
            topMargin: styling.topMargin; bottomMargin: styling.bottomMargin
        }
        property alias styledItem: choiceList
        sourceComponent: styling.label
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
        listItem: styling.listItem
        popupFrame: styling.popupFrame
    }

    SystemPalette { id: syspal }
    DefaultStyles.ChoiceListStyle { id: defaultStyle }
}
