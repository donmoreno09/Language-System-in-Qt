#include "languagemanager.h"
#include <QGuiApplication>
#include <QLocale>
#include <QDebug>

const QString LanguageManager::SETTINGS_LANGUAGE_KEY = "language";

LanguageManager::LanguageManager(QQmlApplicationEngine* engine, QObject* parent)
    : QObject(parent)
    , m_engine(engine)
    , m_translator(nullptr)
    , m_currentLanguage("en")
    , m_settings("TaskManager", "TaskManager")
{
    initializeAvailableLanguages();
}

void LanguageManager::initializeAvailableLanguages()
{
    // Configure supported languages
    m_availableLanguages = {"en", "es", "fr", "it"};

    // Display names in each language
    m_languageDisplayNames["en"] = "English";
    m_languageDisplayNames["es"] = "Español";
    m_languageDisplayNames["fr"] = "Français";
    m_languageDisplayNames["it"] = "Italiano";

    // Flag emojis
    m_languageFlags["en"] = "🇺🇸";
    m_languageFlags["es"] = "🇪🇸";
    m_languageFlags["fr"] = "🇫🇷";
    m_languageFlags["it"] = "🇮🇹";
}

QString LanguageManager::currentLanguage() const
{
    return m_currentLanguage;
}

QStringList LanguageManager::availableLanguages() const
{
    return m_availableLanguages;
}

QString LanguageManager::currentLanguageDisplayName() const
{
    return getLanguageDisplayName(m_currentLanguage);
}

bool LanguageManager::setLanguage(const QString& languageCode)
{
    if (m_currentLanguage == languageCode) {
        return true;
    }

    if (!m_availableLanguages.contains(languageCode)) {
        qWarning() << "Unsupported language:" << languageCode;
        emit languageLoadFailed(languageCode);
        return false;
    }

    // Remove previous translator
    removeCurrentTranslation();

    // For English, we don't need to load translations (source language)
    if (languageCode == "en") {
        m_currentLanguage = languageCode;
        if (m_engine) {
            m_engine->retranslate();
        }
        emit languageChanged();
        return true;
    }

    // Load new translation
    if (loadTranslation(languageCode)) {
        m_currentLanguage = languageCode;
        if (m_engine) {
            m_engine->retranslate();
        }
        emit languageChanged();
        qDebug() << "Language changed to:" << languageCode;
        return true;
    } else {
        qWarning() << "Failed to load translation for:" << languageCode;
        emit languageLoadFailed(languageCode);
        return false;
    }
}

QString LanguageManager::getLanguageDisplayName(const QString& languageCode) const
{
    return m_languageDisplayNames.value(languageCode, languageCode);
}

QString LanguageManager::getLanguageFlag(const QString& languageCode) const
{
    return m_languageFlags.value(languageCode, "🏳️");
}

bool LanguageManager::loadTranslation(const QString& languageCode)
{
    m_translator = std::make_unique<QTranslator>(this);

    QString translationFile = QString(":/translations/app_%1.qm").arg(languageCode);

    if (m_translator->load(translationFile)) {
        qApp->installTranslator(m_translator.get());
        qDebug() << "Loaded translation:" << translationFile;
        return true;
    } else {
        qWarning() << "Failed to load translation file:" << translationFile;
        m_translator.reset();
        return false;
    }
}

void LanguageManager::removeCurrentTranslation()
{
    if (m_translator) {
        qApp->removeTranslator(m_translator.get());
        m_translator.reset();
    }
}

void LanguageManager::saveLanguagePreference()
{
    m_settings.setValue(SETTINGS_LANGUAGE_KEY, m_currentLanguage);
    qDebug() << "Language preference saved:" << m_currentLanguage;
}

void LanguageManager::loadLanguagePreference()
{
    QString savedLanguage = m_settings.value(SETTINGS_LANGUAGE_KEY, "en").toString();
    setLanguage(savedLanguage);
    qDebug() << "Language preference loaded:" << savedLanguage;
}

void LanguageManager::initializeLanguage()
{
    // Try to load user preference, fallback to system locale, then English
    QString preferredLanguage = m_settings.value(SETTINGS_LANGUAGE_KEY).toString();

    if (preferredLanguage.isEmpty()) {
        QString systemLocale = QLocale::system().name().left(2);
        if (m_availableLanguages.contains(systemLocale)) {
            preferredLanguage = systemLocale;
        } else {
            preferredLanguage = "en";
        }
    }

    setLanguage(preferredLanguage);
}
