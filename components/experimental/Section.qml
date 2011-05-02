import QtQuick 1.1

Item {
    id: section

    implicitWidth: column.implicitWidth
    implicitHeight: column.implicitHeight

    default property alias content: column.children

    Column {
        id: column
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        onChildrenChanged: {
            var items = column.children;
            var count = items.length;

            for (var i = 0; i < count; i++) {
                if (count == 1)
                    items[i].__position = "";
                else if (i == 0)
                    items[i].__position = "top";
                else if (i == count - 1)
                    items[i].__position = "bottom";
                else
                    items[i].__position = "center";
            }
        }
    }
}
