#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QLocale>
#include <QTranslator>
#include <QIcon>

#include "LanguageManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Set application properties
    app.setApplicationName("LanguageSystem_ApprendimentoV2");
    app.setApplicationDisplayName("LanguageSystem_ApprendimentoV2");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("YourCompany");
    app.setOrganizationDomain("yourcompany.com");

    // Create QML engine
    QQmlApplicationEngine engine;

    // Create and configure language manager
    LanguageManager languageManager(&engine);

    // Register language manager as singleton
    qmlRegisterSingletonInstance("LanguageSystem_ApprendimentoV2", 1, 0, "LanguageManager", &languageManager);

    // Load main QML file
    const QUrl url(QStringLiteral("qrc:/qt/qml/LanguageSystem_ApprendimentoV2/src/qml/Main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl) {
                             QCoreApplication::exit(-1);
                         }
                     }, Qt::QueuedConnection);

    engine.load(url);

    // Initialize language after QML is loaded
    QMetaObject::invokeMethod(&languageManager, "initializeLanguage", Qt::QueuedConnection);

    return app.exec();
}
