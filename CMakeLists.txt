cmake_minimum_required(VERSION 3.16)

project(qml-page-menu VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 6.2 COMPONENTS QuickControls2 REQUIRED)

qt_add_executable(appqml-page-menu
    main.cpp
)

qt_add_qml_module(appqml-page-menu
    URI qml-page-menu
    VERSION 1.0
    QML_FILES
        main.qml
        DrawerItem.qml
        PageDrawer.qml
        SvgImage.qml
        pages/APage.qml
        pages/BPage.qml
        pages/CPage.qml
        pages/DPage.qml
    RESOURCES
        images/apple.png
        images/apple.svg
        images/banana.png
        images/banana.svg
        images/cherry.png
        images/cherry.svg
        images/durian.png
        images/durian.svg
        images/logo.png
        images/menu.png
)

set_target_properties(appqml-page-menu PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqml-page-menu
    PRIVATE Qt6::Quick)

install(TARGETS appqml-page-menu
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
