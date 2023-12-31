cmake_minimum_required(VERSION 3.14)

project(pi-oneer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick)

set(PROJECT_SOURCES
        src/musictablemodel.h
        src/musictablemodel.cpp
        src/musictagparser.h
        src/musictagparser.cpp
        src/main.cpp
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(pi-oneer
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )

    qt_add_qml_module(pi-oneer
        URI pioneer
        VERSION 1.0
        QML_FILES src/main.qml
            src/Clock.qml
            src/HomePage.qml
            src/LargeButton.qml
            src/RoundImage.qml
            src/SettingsPage.qml
            src/MusicPage.qml
    )

    qt_add_resources(pi-oneer "icons"
        BASE "icons"
        PREFIX "/icons"
        FILES icons/cable.svg
            icons/music_note.svg
            icons/navigate_before.svg
            icons/navigate_before_white.svg
            icons/navigate_next.svg
            icons/navigate_next_white.svg
            icons/near_me.svg
            icons/pause.svg
            icons/play_arrow.svg
            icons/radio.svg
            icons/settings.svg
            icons/vinyl.jpg
    )

# Define target properties for Android with Qt 6 as:
#    set_property(TARGET Pi-oneer APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    set(PROJECT_SOURCES
        ${PROJECT_SOURCES}
        icons/icons.qrc
        qml.qrc)

    if(ANDROID)
        add_library(pi-oneer SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(pi-oneer
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(pi-oneer
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick -lid3)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.Pi-oneer)
endif()
set_target_properties(pi-oneer PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS pi-oneer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(pi-oneer)
    qt_finalize_executable(pi-oneer)
endif()
