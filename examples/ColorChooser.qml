import QtQuick 1.1
import "../components"

Item {
    id: root
    width: 650
    height: 400

    property variant rgbColor: Qt.rgba(red.value / 255, green.value / 255, blue.value / 255, 1)
//    property variant hslColor: Qt.hsla(hue.value / 255, saturation.value / 255, lightness.value / 255, 1)

    Row {
        spacing:  20
        Rectangle {
            height: root.height
            width: height
            border { color: "black"; width: 2 }
            color: rgbColor
        }

        Column {
            spacing: 20

            SlideBoxr { id: red }
            SlideBoxr { id: green }
            SlideBoxr { id: blue }

//            SlideBoxr { id: hue }
//            SlideBoxr { id: saturation }
//            SlideBoxr { id: lightness }


            Row {
                CheckBox {
                    id: bwCB
                    checked: false
                }
                Text {
                    text: "B&W Binding Power!"
                }
            }
            Binding {
                target: green
                property: "value"
                value: red.value
                when: bwCB.checked
            }
            Binding {
                target: blue
                property: "value"
                value: red.value
                when: bwCB.checked
            }
            Binding {
                target: red
                property: "value"
                value: green.value
                when: bwCB.checked
            }
            Binding {
                target: blue
                property: "value"
                value: green.value
                when: bwCB.checked
            }
            Binding {
                target: red
                property: "value"
                value: blue.value
                when: bwCB.checked
            }
            Binding {
                target: green
                property: "value"
                value: blue.value
                when: bwCB.checked
            }
        }
    }

}
