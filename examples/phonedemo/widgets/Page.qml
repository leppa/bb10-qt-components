import QtQuick 1.1
import "../../../components"

Item {
    id: page

    signal back();
    signal next(string filename);

    property string title

    property Component menuDelegate: PageMenu {
        title: page.title
    }

    width: parent != null ? parent.width : 0
    height: parent != null ? parent.height : 0
}
