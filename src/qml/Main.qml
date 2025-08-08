import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import LanguageSystem_ApprendimentoV2 1.0
import "components"
import "pages"

ApplicationWindow {
    id: window
    width: 1200
    height: 800
    visible: true
    title: qsTr("Task Manager Pro")
    
    property color primaryColor: "#6366f1"
    property color secondaryColor: "#8b5cf6"
    property color backgroundColor: "#f8fafc"
    property color surfaceColor: "#ffffff"
    property color textColor: "#1e293b"
    property color textSecondaryColor: "#64748b"
    
    color: backgroundColor

    // Modern header with gradient
    header: Rectangle {
        height: 70
        gradient: Gradient {
            GradientStop { position: 0.0; color: primaryColor }
            GradientStop { position: 1.0; color: secondaryColor }
        }
        
        DropShadow {
            anchors.fill: parent
            source: parent
            verticalOffset: 2
            radius: 8
            samples: 17
            color: "#40000000"
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            // App icon and title
            Row {
                spacing: 15
                
                Rectangle {
                    width: 40
                    height: 40
                    radius: 20
                    color: "#ffffff20"
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Text {
                        anchors.centerIn: parent
                        text: "✓"
                        font.pixelSize: 20
                        color: "white"
                        font.bold: true
                    }
                }
                
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Label {
                        text: qsTr("Task Manager Pro")
                        font.bold: true
                        font.pixelSize: 22
                        color: "white"
                    }
                    
                    Label {
                        text: qsTr("Organize your productivity")
                        font.pixelSize: 12
                        color: "#ffffff80"
                    }
                }
            }

            Item { Layout.fillWidth: true }

            // Language selector with modern styling
            LanguageSelector {
                Layout.preferredWidth: 180
            }
        }
    }

    // Main content with sidebar
    RowLayout {
        anchors.fill: parent
        spacing: 0
        
        // Sidebar (optional - can be hidden)
        Rectangle {
            id: sidebar
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            color: surfaceColor
            visible: window.width > 900
            
            Rectangle {
                anchors.right: parent.right
                width: 1
                height: parent.height
                color: "#e2e8f0"
            }
            
            Column {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15
                
                Label {
                    text: qsTr("Quick Stats")
                    font.bold: true
                    font.pixelSize: 16
                    color: textColor
                }
                
                Rectangle {
                    width: parent.width
                    height: 80
                    radius: 12
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#f1f5f9" }
                        GradientStop { position: 1.0; color: "#e2e8f0" }
                    }
                    
                    Column {
                        anchors.centerIn: parent
                        
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "0"
                            font.pixelSize: 24
                            font.bold: true
                            color: primaryColor
                        }
                        
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("Total Tasks")
                            font.pixelSize: 12
                            color: textSecondaryColor
                        }
                    }
                }
                
                Item { height: 20 }
                
                Label {
                    text: qsTr("Quick Actions")
                    font.bold: true
                    font.pixelSize: 16
                    color: textColor
                }
                
                Button {
                    width: parent.width
                    text: qsTr("+ New Task")
                    font.bold: true
                    
                    background: Rectangle {
                        radius: 8
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: primaryColor }
                            GradientStop { position: 1.0; color: secondaryColor }
                        }
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: taskListPage.addNewTask()
                }
            }
        }
        
        // Main content area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: backgroundColor
            
            StackView {
                id: stackView
                anchors.fill: parent
                anchors.margins: 20
                initialItem: taskListPage

                TaskListPage {
                    id: taskListPage
                }
            }
        }
    }

    // Modern status bar
    footer: Rectangle {
        height: 35
        color: surfaceColor
        
        Rectangle {
            anchors.top: parent.top
            width: parent.width
            height: 1
            color: "#e2e8f0"
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 12

            Row {
                spacing: 8
                
                Rectangle {
                    width: 8
                    height: 8
                    radius: 4
                    color: "#10b981"
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                Label {
                    text: qsTr("Ready")
                    font.pixelSize: 11
                    color: textSecondaryColor
                }
            }

            Item { Layout.fillWidth: true }
            
            Label {
                text: qsTr("Language: %1").arg(LanguageManager.currentLanguageDisplayName)
                font.pixelSize: 11
                color: textSecondaryColor
            }
        }
    }

    // Global shortcuts
    Shortcut {
        sequence: "Ctrl+N"
        onActivated: taskListPage.addNewTask()
    }

    Shortcut {
        sequence: "Ctrl+Q"
        onActivated: Qt.quit()
    }

    // Language change handler
    Connections {
        target: LanguageManager
        function onLanguageChanged() {
            console.log("Language changed to:", LanguageManager.currentLanguage);
            // Save preference automatically
            LanguageManager.saveLanguagePreference();
        }
    }
}
