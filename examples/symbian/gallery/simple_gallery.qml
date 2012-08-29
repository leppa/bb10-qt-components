import QtQuick 2.0
import com.nokia.symbian 1.1

// Example that shows slowness on Blackberry. The more buttons there are, the slower it gets
Window {

    Flickable {
        clip: true
        contentHeight: column.height
        anchors.fill: parent

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right

            Repeater {
                model: 40 // more == slower

                Button {
                    text: "Push me " + index
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
        }
    }
}
