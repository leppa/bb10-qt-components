TEMPLATE = subdirs # XXX: Avoid call the linker
TARGETPATH = Qt/labs/components/templates

symbian {
    INSTALL_IMPORTS = /resource/qt/imports
} else {
    INSTALL_IMPORTS = $$[QT_INSTALL_IMPORTS]
}

QML_FILES = \
        qmldir \
        BasicButton.qml \
        BusyIndicator.qml \
        ButtonBlock.qml \
        ButtonColumn.qml \
        ButtonRow.qml \
        ButtonGroup.js \
        Button.qml \
        CheckBox.qml \
        ProgressBar.qml \
        RadioButton.qml \
        ScrollDecorator.qml \
        Slider.qml \
        SpinBox.qml \
        Switch.qml \
        TextArea.qml \
        TextField.qml

QML_DIRS = \
        behaviors \
        private \
        styles

qmlfiles.files = $$QML_FILES
qmlfiles.sources = $$QML_FILES
qmlfiles.path = $$INSTALL_IMPORTS/$$TARGETPATH

qmldirs.files = $$QML_DIRS
qmldirs.sources = $$QML_DIRS
qmldirs.path = $$INSTALL_IMPORTS/$$TARGETPATH

INSTALLS += qmlfiles qmldirs

symbian {
    DEPLOYMENT += qmlfiles qmldirs
}
