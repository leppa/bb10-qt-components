import QtQuick 1.1

Loader {
    id: loader

    property url filepath
    property Component delegate: null

    Binding {
        target: loader
        property: "source"
        value: loader.filepath
        when: loader.delegate == null
    }

    Binding {
        target: loader
        property: "sourceComponent"
        value: loader.delegate
        when: loader.delegate != null
    }
}
