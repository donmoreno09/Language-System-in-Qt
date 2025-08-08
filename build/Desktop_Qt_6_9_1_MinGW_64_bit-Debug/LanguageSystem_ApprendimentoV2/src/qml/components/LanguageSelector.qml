import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects
import LanguageSystem_ApprendimentoV2 1.0

ComboBox {
    id: languageSelector
    
    property color primaryColor: "#6366f1"
    property color surfaceColor: "#ffffff"
    property color textColor: "#1e293b"
    property color borderColor: "#e2e8f0"

    model: LanguageManager.availableLanguages
    currentIndex: model.indexOf(LanguageManager.currentLanguage)
    
    background: Rectangle {
        radius: 8
        color: "#ffffff20"
        border.color: "#ffffff40"
        border.width: 1
        
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "#ffffff10"
            visible: parent.parent.hovered
        }
    }
    
    indicator: Text {
        x: languageSelector.width - width - 12
        y: languageSelector.topPadding + (languageSelector.availableHeight - height) / 2
        text: "\u25BC"
        font.pixelSize: 10
        color: "#ffffff80"
    }

    delegate: ItemDelegate {
        width: languageSelector.width
        height: 45
        
        background: Rectangle {
            color: highlighted ? primaryColor + "20" : "transparent"
            radius: 6
        }
        
        contentItem: Row {
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12
            
            Text {
                text: LanguageManager.getLanguageFlag(modelData)
                font.pixelSize: 18
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Text {
                text: LanguageManager.getLanguageDisplayName(modelData)
                font.pixelSize: 14
                font.weight: Font.Medium
                color: highlighted ? primaryColor : textColor
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        highlighted: languageSelector.highlightedIndex === index
    }
    
    popup: Popup {
        y: languageSelector.height + 5
        width: languageSelector.width
        height: Math.min(contentItem.implicitHeight + 20, 200)
        padding: 10
        
        background: Rectangle {
            color: surfaceColor
            radius: 12
            border.color: borderColor
            border.width: 1
            
            DropShadow {
                anchors.fill: parent
                source: parent
                verticalOffset: 4
                radius: 16
                samples: 33
                color: "#40000000"
            }
        }
        
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: languageSelector.popup.visible ? languageSelector.delegateModel : null
            currentIndex: languageSelector.highlightedIndex
            spacing: 2
            
            ScrollIndicator.vertical: ScrollIndicator {
                active: parent.contentHeight > parent.height
            }
        }
    }

    contentItem: Row {
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Text {
            text: LanguageManager.getLanguageFlag(LanguageManager.currentLanguage)
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: LanguageManager.currentLanguageDisplayName
            font.pixelSize: 13
            font.weight: Font.Medium
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    onActivated: {
        var selectedLanguage = model[index];
        if (selectedLanguage !== LanguageManager.currentLanguage) {
            LanguageManager.setLanguage(selectedLanguage);
        }
    }

    // Update when language changes externally
    Connections {
        target: LanguageManager
        function onLanguageChanged() {
            languageSelector.currentIndex = languageSelector.model.indexOf(LanguageManager.currentLanguage);
        }
    }
}
