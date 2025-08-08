cmake_minimum_required(VERSION 3.16)

project(LanguageSystem_ApprendimentoV2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appLanguageSystem_ApprendimentoV2
    src/main.cpp
)

qt_add_translations(appLanguageSystem_ApprendimentoV2 TS_FILES translations/app_it.ts)

qt_add_qml_module(appLanguageSystem_ApprendimentoV2
    URI LanguageSystem_ApprendimentoV2
    VERSION 1.0
    QML_FILES
        src/qml/Main.qml
        SOURCES src/LanguageManager.h src/LanguageManager.cpp
        QML_FILES src/qml/components/LanguageSelector.qml
        QML_FILES src/qml/components/TaskItem.qml
        QML_FILES src/qml/components/AddTaskDialog.qml
        QML_FILES src/qml/pages/TaskListPage.qml
        RESOURCES resource/qml.qrc
        RESOURCES resource/translations.qrc
        RESOURCES README.md
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appLanguageSystem_ApprendimentoV2 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appLanguageSystem_ApprendimentoV2
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appLanguageSystem_ApprendimentoV2
    PRIVATE Qt6::Quick
)
target_link_libraries(appLanguageSystem_ApprendimentoV2 PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appLanguageSystem_ApprendimentoV2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
