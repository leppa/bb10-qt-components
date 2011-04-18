include (../tests.pri)

TEMPLATE = app
TARGET = tst_apicheck
CONFIG += qtestlib testcase

INCLUDEPATH += . base

HEADERS += base/apicheckbase.h \
           busyindicator/apicheck_busyindicator.h \
           button/apicheck_button.h \
           buttoncolumn/apicheck_buttoncolumn.h \
           buttonrow/apicheck_buttonrow.h \
           checkbox/apicheck_checkbox.h \
           choicelist/apicheck_choicelist.h \
           contextmenu/apicheck_contextmenu.h \
           dialog/apicheck_dialog.h \
           menu/apicheck_menu.h \
           menuitem/apicheck_menuitem.h \
           page/apicheck_page.h \
           pagestack/apicheck_pagestack.h \
           progressbar/apicheck_progressbar.h \
           querydialog/apicheck_querydialog.h \
           radiobutton/apicheck_radiobutton.h \
           ratingindicator/apicheck_ratingindicator.h \
           screen/apicheck_screen.h \
           scrolldecorator/apicheck_scrolldecorator.h \
           sectionscroller/apicheck_sectionscroller.h \
           selectiondialog/apicheck_selectiondialog.h \
           slider/apicheck_slider.h \
           switch/apicheck_switch.h \
           tabbutton/apicheck_tabbutton.h \
           tabgroup/apicheck_tabgroup.h \
           textarea/apicheck_textarea.h \
           textfield/apicheck_textfield.h \
           toolbar/apicheck_toolbar.h \
           tumbler/apicheck_tumbler.h \
           tumbler/apicheck_tumblercolumn.h \
           tumblerdialog/apicheck_tumblerdialog.h \
           window/apicheck_window.h

SOURCES += tst_apicheck.cpp \
           base/apicheckbase.cpp \
           busyindicator/apicheck_busyindicator.cpp \
           button/apicheck_button.cpp \
           buttoncolumn/apicheck_buttoncolumn.cpp \
           buttonrow/apicheck_buttonrow.cpp \
           checkbox/apicheck_checkbox.cpp \
           choicelist/apicheck_choicelist.cpp \
           dialog/apicheck_dialog.cpp \
           menu/apicheck_menu.cpp \
           menuitem/apicheck_menuitem.cpp \
           page/apicheck_page.cpp \
           pagestack/apicheck_pagestack.cpp \
           querydialog/apicheck_querydialog.cpp \
           radiobutton/apicheck_radiobutton.cpp \
           ratingindicator/apicheck_ratingindicator.cpp \
           screen/apicheck_screen.cpp \
           sectionscroller/apicheck_sectionscroller.cpp \
           selectiondialog/apicheck_selectiondialog.cpp \
           slider/apicheck_slider.cpp \
           switch/apicheck_switch.cpp \
           tabbutton/apicheck_tabbutton.cpp \
           tabgroup/apicheck_tabgroup.cpp \
           textarea/apicheck_textarea.cpp \
           textfield/apicheck_textfield.cpp \
           toolbar/apicheck_toolbar.cpp \
           tumbler/apicheck_tumbler.cpp \
           tumbler/apicheck_tumblercolumn.cpp \
           tumblerdialog/apicheck_tumblerdialog.cpp \
           window/apicheck_window.cpp