# Generated from msaarenderbuffer.pro.

#####################################################################
## msaarenderbuffer Binary:
#####################################################################

qt_add_manual_test(msaarenderbuffer
    GUI
    SOURCES
        msaarenderbuffer.cpp
    PUBLIC_LIBRARIES
        Qt::Gui
        Qt::GuiPrivate
)

# Resources:
set_source_files_properties("../shared/color.frag.qsb"
    PROPERTIES QT_RESOURCE_ALIAS "color.frag.qsb"
)
set_source_files_properties("../shared/color.vert.qsb"
    PROPERTIES QT_RESOURCE_ALIAS "color.vert.qsb"
)
set_source_files_properties("../shared/texture.frag.qsb"
    PROPERTIES QT_RESOURCE_ALIAS "texture.frag.qsb"
)
set_source_files_properties("../shared/texture.vert.qsb"
    PROPERTIES QT_RESOURCE_ALIAS "texture.vert.qsb"
)
set(msaarenderbuffer_resource_files
    "../shared/color.frag.qsb"
    "../shared/color.vert.qsb"
    "../shared/texture.frag.qsb"
    "../shared/texture.vert.qsb"
)

qt_add_resource(msaarenderbuffer "msaarenderbuffer"
    PREFIX
        "/"
    FILES
        ${msaarenderbuffer_resource_files}
)


#### Keys ignored in scope 1:.:.:msaarenderbuffer.pro:<TRUE>:
# TEMPLATE = "app"
