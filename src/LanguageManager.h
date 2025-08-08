#ifndef LANGUAGEMANAGER_H
#define LANGUAGEMANAGER_H

#include <QObject>
#include <QTranslator>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QStringList>
#include <QHash>
#include <memory>

class LanguageManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentLanguage READ currentLanguage NOTIFY languageChanged)
    Q_PROPERTY(QStringList availableLanguages READ availableLanguages CONSTANT)
    Q_PROPERTY(QString currentLanguageDisplayName READ currentLanguageDisplayName NOTIFY languageChanged)

public:
    explicit LanguageManager(QQmlApplicationEngine* engine, QObject* parent = nullptr);

    // Property getters
    QString currentLanguage() const;
    QStringList availableLanguages() const;
    QString currentLanguageDisplayName() const;

    // Invokable methods for QML
    Q_INVOKABLE bool setLanguage(const QString& languageCode);
    Q_INVOKABLE QString getLanguageDisplayName(const QString& languageCode) const;
    Q_INVOKABLE QString getLanguageFlag(const QString& languageCode) const;
    Q_INVOKABLE void saveLanguagePreference();
    Q_INVOKABLE void loadLanguagePreference();

public slots:
    void initializeLanguage();

signals:
    void languageChanged();
    void languageLoadFailed(const QString& languageCode);

private:
    void initializeAvailableLanguages();
    bool loadTranslation(const QString& languageCode);
    void removeCurrentTranslation();

    QQmlApplicationEngine* m_engine;
    std::unique_ptr<QTranslator> m_translator;
    QString m_currentLanguage;
    QStringList m_availableLanguages;
    QHash<QString, QString> m_languageDisplayNames;
    QHash<QString, QString> m_languageFlags;
    QSettings m_settings;

    static const QString SETTINGS_LANGUAGE_KEY;
};

#endif // LANGUAGEMANAGER_H
