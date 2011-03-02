import QtQuick 1.1
import "../components"

Rectangle {
    width: 640
    height: 954

    Flickable {
        id: flickable
        objectName: "The flickable"
        anchors.fill: parent
        contentHeight: toField.height+subjectField.height+bodyText.implicitHeight
        clip: true
        TextField {
            id: toField
            anchors {
                left: parent.left; right: parent.right
                top: parent.top
            }
            placeholderText: "To"
        }

        TextField {
            id: subjectField
            anchors {
                left: parent.left; right: parent.right
                top: toField.bottom
            }
            placeholderText: "Subject"
        }

        TextArea {
            id: bodyText
            anchors {
                left: parent.left; right: parent.right
                top: subjectField.bottom; bottom: parent.bottom
            }
            flickHandler: flickable
            placeholderText: ""
            Component.onCompleted: {
                for(var i = 0; i < 30; i++) {
                    text += "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.\n"
                }
            }

        }
    }

    ScrollIndicator {
        scrollItem: flickable
    }

//    PinchArea {
//        anchors.fill: parent
//    }

}



