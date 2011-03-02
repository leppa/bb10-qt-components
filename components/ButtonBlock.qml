import QtQuick 1.1
import "./behaviors"    // ButtonBehavior
import "./visuals"      // AdjoiningVisual
import "./styles/default" as DefaultStyles

// KNOWN ISSUES
// 1) Should be generalized into JoinedGroup and ButtonBlock made a specialization.
// 2) ExclusiveSelection support missing

// NOTES
// 1) The ButtonBlock implementation has no ultimate dependency on AdjoiningVisual, and can therefor be made to work
//    with any Component for the item instances. The use of AdjoiningVisual is only for simplifying the implementation
//    and styling of the items in the block. The property defining how an item in the block should be joinged with its
//    neighbours is "adjoins" which the ButtonBlock "attaches" to the items in the block (i.e. defines in their
//    look-up scope) which means the "button" instances does not need to define this property, only read it to draw
//    their border appropriately. This "adjoins" property is a *completely* separate concept from the AdjoiningVisual.
//    I.e. the coupling between the ButtonGroup and the "button" elements making up the group is the weakest possible.


Item {
    id: buttonBlock

    property alias model: repeater.model
    property variant bindings: {"text":"text", "iconSource":"iconSource", "enabled":"enabled", "opacity":"opacity"}

    property int orientation: Qt.Horizontal
    signal clicked(int index)

    property Component buttonBackground: defaultStyle.background
    property Component buttonLabel: defaultStyle.label

    property color backgroundColor: syspal.button
    property color textColor: syspal.text;

    property int leftMargin: defaultStyle.leftMargin
    property int topMargin: defaultStyle.topMargin
    property int rightMargin: defaultStyle.rightMargin
    property int bottomMargin: defaultStyle.bottomMargin

    // implementation

    implicitWidth: orientation == Qt.Horizontal ? grid.implicitWidth : grid.widestItemWidth
    implicitHeight: orientation == Qt.Horizontal ? grid.talestItemHeight : grid.implicitHeight

    onOrientationChanged: grid.updateImplicitSize()
    onModelChanged: grid.updateImplicitSize()

    Grid {
        id: grid
        columns: orientation == Qt.Vertical || !model ? 1 : model.count
        anchors.centerIn: parent
        property int widestItemWidth: 0
        property int talestItemHeight: 0

        function updateImplicitSize() {
            var biggest = 0;
            for(var i = 0; i < repeater.count; i++) {
                var button = repeater.itemAt(i);
                if(Qt.isQtObject(button)) {
                    biggest = Math.max(biggest, buttonBlock.orientation == Qt.Horizontal ? button.implicitHeight : button.implicitWidth);
                }
            }
            if(buttonBlock.orientation == Qt.Horizontal)
                talestItemHeight = biggest;
            else
                widestItemWidth = biggest;
        }

        property int leftmostVisibleIndex
        property int rightmostVisibleIndex
        property int topmostVisibleIndex
        property int bottommostVisibleIndex

        move: Transition {
            PropertyAction { properties: "x,y" }
            ScriptAction { script: {
                    if(orientation == Qt.Horizontal) {
                        grid.leftmostVisibleIndex = grid.findFirstOrLastVisibleItemIndex(grid.compareForLeftmost, 1000000);
                        grid.rightmostVisibleIndex = grid.findFirstOrLastVisibleItemIndex(grid.compareForRightmost, -1000000);
                    } else {
                        grid.topmostVisibleIndex = grid.findFirstOrLastVisibleItemIndex(grid.compareForTopmost, 1000000);
                        grid.bottommostVisibleIndex = grid.findFirstOrLastVisibleItemIndex(grid.compareForBottommost, -1000000);
                    }
                }
            }
        }

        function compareForLeftmost(child, coordinate) { return Math.min(child.x, coordinate); }
        function compareForRightmost(child, coordinate) { return Math.max(child.x, coordinate); }
        function compareForTopmost(child, coordinate) { return Math.min(child.y, coordinate); }
        function compareForBottommost(child, coordinate) { return Math.max(child.y, coordinate); }

        function findFirstOrLastVisibleItemIndex(compareFunc, initialCoordinate) {
            var index = 0;
            var coordinate = initialCoordinate
            for(var i = 0; i < repeater.count; i++) {
                var button = repeater.itemAt(i);
                if(!Qt.isQtObject(button)) continue;
                var c = compareFunc(button, coordinate);
                if(c != coordinate && button.opacity > 0) {
                    coordinate = c;
                    index = i;
                }
            }
            return index;
        }

        Repeater {
            id: repeater
            delegate: AdjoiningVisual {
                id: blockButton
                styledItem: blockButton
                styling: buttonBackground

                property alias pressed: behavior.pressed
                property alias containsMouse: behavior.containsMouse
                property alias checkable: behavior.checkable  // button toggles between checked and !checked
                property alias checked: behavior.checked

                property string text
                property url iconSource
                property color textColor: buttonBlock.textColor
                property color backgroundColor: buttonBlock.backgroundColor

                width: buttonBlock.orientation == Qt.Horizontal ? implicitWidth : grid.widestItemWidth
                height: buttonBlock.orientation == Qt.Horizontal ? grid.talestItemHeight : implicitHeight

                Component.onCompleted: {
                    // Create the Binding objects defined by the ButtonBlock's "bindings" map property to allow
                    // the properties of the buttons to be bound to properties in the model with different names

                    if (bindings == undefined) // jb : bindings is undefined on Mac
                        return;
                    var keys = Object.keys(buttonBlock.bindings);
                    for(var i = 0; i < keys.length; i++) {
                        var key = keys[i];
                        var bindingComponent =
                                'import QtQuick 1.0;' +
                                'Binding {' +
                                '    target: blockButton;' +
                                '    property: "' + key + '";' +
                                '    value: buttonBlock.model.get(' + index + ').' + bindings[key] + ';' +
                                '}';
                        Qt.createQmlObject(bindingComponent, blockButton);    //mm do we ever need to explicitly delete these?
                    }
                }

                ButtonBehavior {
                    id: behavior
                    anchors.fill: parent
                    onClicked: buttonBlock.clicked(index)
                }

                property int adjoins
                adjoins: {   //mm see QTBUG-14987
                    var adjoins;
                    if(orientation == Qt.Horizontal) {
                        adjoins = 0x1|0x2;  // left and right
                        if(index == grid.leftmostVisibleIndex) adjoins &= ~0x1;   // not left
                        if(index == grid.rightmostVisibleIndex) adjoins &= ~0x2;  // not right
                    } else {
                        adjoins = 0x4|0x8;  // top and bottom
                        if(index == grid.topmostVisibleIndex) adjoins &= ~0x4;    // not top
                        if(index == grid.bottommostVisibleIndex) adjoins &= ~0x8; // not bottom
                    }
                    return adjoins;
                }


                property int minimumWidth: defaultStyle.minimumWidth
                property int minimumHeight: defaultStyle.minimumHeight

                implicitWidth: opacity > 0 ? Math.max(minimumWidth,
                                 labelComponent.item.implicitWidth + leftMargin + rightMargin) : 0
                implicitHeight: opacity > 0 ? Math.max(minimumHeight,
                                  labelComponent.item.implicitHeight + topMargin + bottomMargin) : 0

                onImplicitWidthChanged: grid.updateImplicitSize()
                onImplicitHeightChanged: grid.updateImplicitSize()

                Loader {
                    id: labelComponent
                    property variant styledItem: blockButton
                    anchors.fill: parent
                    anchors.leftMargin: leftMargin
                    anchors.rightMargin: rightMargin
                    anchors.topMargin: topMargin
                    anchors.bottomMargin: bottomMargin
                    sourceComponent: buttonLabel
                }

            }
        }
    }

    SystemPalette { id: syspal; colorGroup: enabled ? SystemPalette.Active : SystemPalette.Disabled }
    DefaultStyles.ButtonBlockStyle { id: defaultStyle }
}
