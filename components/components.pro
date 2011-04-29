TEMPLATE = lib
TARGET = $$qtLibraryTarget(componentsplugin)
TARGETPATH = QtLabs/components
INCLUDEPATH += $$PWD

QT += declarative

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
        ChoiceList.qml \
        ProgressBar.qml \
        RadioButton.qml \
        ScrollDecorator.qml \
        Slider.qml \
        Switch.qml \
        TextArea.qml \
        DualLoader.qml \
        TextField.qml

QML_DIRS = \
        behaviors \
        private \
        styles \
        visuals \
        themes

SOURCES += plugin.cpp

include("kernel/kernel.pri")
include("models/models.pri")

qmlfiles.files = $$QML_FILES
qmlfiles.sources = $$QML_FILES
qmlfiles.path = $$INSTALL_IMPORTS/$$TARGETPATH

qmldirs.files = $$QML_DIRS
qmldirs.sources = $$QML_DIRS
qmldirs.path = $$INSTALL_IMPORTS/$$TARGETPATH

target.path = $$INSTALL_IMPORTS/$$TARGETPATH

INSTALLS += target qmlfiles qmldirs

symbian {
    DEPLOYMENT += qmlfiles qmldirs
}
