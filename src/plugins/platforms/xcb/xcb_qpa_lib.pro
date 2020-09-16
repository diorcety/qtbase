TARGET     = QtXcbQpa
CONFIG += no_module_headers internal_module
DEFINES += QT_NO_FOREACH

QT += \
    core-private gui-private \
    service_support-private theme_support-private \
    fontdatabase_support-private \
    edid_support-private

qtHaveModule(linuxaccessibility_support-private): \
    QT += linuxaccessibility_support-private

qtConfig(vulkan): QT += vulkan_support-private

qtConfig(glib) : QMAKE_USE_PRIVATE += glib

SOURCES = \
        qxcbclipboard.cpp \
        qxcbconnection.cpp \
        qxcbintegration.cpp \
        qxcbkeyboard.cpp \
        qxcbmime.cpp \
        qxcbscreen.cpp \
        qxcbwindow.cpp \
        qxcbbackingstore.cpp \
        qxcbwmsupport.cpp \
        qxcbnativeinterface.cpp \
        qxcbcursor.cpp \
        qxcbimage.cpp \
        qxcbxsettings.cpp \
        qxcbsystemtraytracker.cpp \
        qxcbeventqueue.cpp \
        qxcbeventdispatcher.cpp \
        qxcbconnection_basic.cpp \
        qxcbconnection_screens.cpp \
        qxcbatom.cpp

HEADERS = \
        qxcbclipboard.h \
        qxcbconnection.h \
        qxcbintegration.h \
        qxcbkeyboard.h \
        qxcbmime.h \
        qxcbobject.h \
        qxcbscreen.h \
        qxcbwindow.h \
        qxcbbackingstore.h \
        qxcbwmsupport.h \
        qxcbnativeinterface.h \
        qxcbcursor.h \
        qxcbimage.h \
        qxcbxsettings.h \
        qxcbsystemtraytracker.h \
        qxcbxkbcommon.h \
        qxcbeventqueue.h \
        qxcbeventdispatcher.h \
        qxcbconnection_basic.h \
        qxcbatom.h

qtConfig(draganddrop) {
    SOURCES += qxcbdrag.cpp
    HEADERS += qxcbdrag.h
}

load(qt_build_paths)

DEFINES += QT_BUILD_XCB_PLUGIN

qtConfig(xcb-xlib) {
    QMAKE_USE += xcb_xlib
}

qtConfig(xcb-xinput) {
    SOURCES += qxcbconnection_xi2.cpp
}

qtConfig(xcb-sm) {
    QMAKE_USE += x11sm
    SOURCES += qxcbsessionmanager.cpp
    HEADERS += qxcbsessionmanager.h
}

include(gl_integrations/gl_integrations.pri)
include(nativepainting/nativepainting.pri)

qtConfig(vulkan) {
    SOURCES += \
        qxcbvulkaninstance.cpp \
        qxcbvulkanwindow.cpp

    HEADERS += \
        qxcbvulkaninstance.h \
        qxcbvulkanwindow.h
}

!qtConfig(system-xcb) {
    QMAKE_USE += xcb-static xcb
} else {
    qtConfig(xkb): QMAKE_USE += xcb_xkb
    qtConfig(xcb-render): QMAKE_USE += xcb_render
    qtConfig(xcb-xinput): QMAKE_USE += xcb_xinput
    QMAKE_USE += xcb_syslibs
}

# libxkbcommon
!qtConfig(xkbcommon-system) {
    qtConfig(xkb) {
        include(../../../3rdparty/xkbcommon-x11.pri)
    } else {
        include(../../../3rdparty/xkbcommon.pri)
    }
} else {
    QMAKE_USE += xkbcommon
}

qtConfig(dlopen): QMAKE_USE += libdl

# qxcbkeyboard.cpp's KeyTbl has more than 256 levels of expansion and older
# Clang uses that as a limit (it's 1024 in current versions).
clang:!intel_icc: QMAKE_CXXFLAGS += -ftemplate-depth=1024

load(qt_module)
