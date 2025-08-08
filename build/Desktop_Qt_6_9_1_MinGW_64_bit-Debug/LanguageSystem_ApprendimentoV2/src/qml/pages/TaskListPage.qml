import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import "../components"

Page {
    id: root
    
    property color primaryColor: "#6366f1"
    property color secondaryColor: "#8b5cf6"
    property color backgroundColor: "#f8fafc"
    property color surfaceColor: "#ffffff"
    property color textColor: "#1e293b"
    property color textSecondaryColor: "#64748b"
    property color successColor: "#10b981"
    property color warningColor: "#f59e0b"
    property color errorColor: "#ef4444"

    property alias tasks: taskModel

    function addNewTask() {
        addTaskDialog.open();
    }
    
    background: Rectangle {
        color: "transparent"
    }

    // Task model with better sample data
    ListModel {
        id: taskModel

        Component.onCompleted: {
            append({
                "title": qsTr("Design new user interface"),
                "description": qsTr("Create modern and intuitive user interface designs for the application"),
                "completed": false,
                "priority": qsTr("High"),
                "dueDate": "2025-01-15",
                "category": "Design"
            });
            append({
                "title": qsTr("Implement authentication system"),
                "description": qsTr("Set up secure user authentication with login and registration"),
                "completed": true,
                "priority": qsTr("High"),
                "dueDate": "2025-01-10",
                "category": "Development"
            });
            append({
                "title": qsTr("Write unit tests"),
                "description": qsTr("Create comprehensive unit tests for all core components"),
                "completed": false,
                "priority": qsTr("Medium"),
                "dueDate": "2025-01-20",
                "category": "Testing"
            });
            append({
                "title": qsTr("Update documentation"),
                "description": qsTr("Update API documentation and user guides"),
                "completed": false,
                "priority": qsTr("Low"),
                "dueDate": "2025-01-25",
                "category": "Documentation"
            });
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 25

        // Header section with modern design
        RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 10

            Column {
                Layout.fillWidth: true
                
                Label {
                    text: qsTr("My Tasks")
                    font.bold: true
                    font.pixelSize: 32
                    color: textColor
                }
                
                Label {
                    text: qsTr("Manage your tasks efficiently")
                    font.pixelSize: 14
                    color: textSecondaryColor
                    topPadding: 5
                }
            }

            Button {
                text: qsTr("+ Add Task")
                font.bold: true
                font.pixelSize: 14
                
                background: Rectangle {
                    radius: 12
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
                        color: primaryColor + "40"
                    }
                }
                
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: addNewTask()
            }
        }

        // Modern statistics cards
        RowLayout {
            Layout.fillWidth: true
            spacing: 20
            
            // Total tasks card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                radius: 16
                color: surfaceColor
                
                DropShadow {
                    anchors.fill: parent
                    source: parent
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    color: "#10000000"
                }
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 8
                    
                    Row {
                        spacing: 12
                        
                        Rectangle {
                            width: 40
                            height: 40
                            radius: 20
                            color: primaryColor + "20"
                            
                            Text {
                                anchors.centerIn: parent
                                text: "📋"
                                font.pixelSize: 18
                            }
                        }
                        
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            
                            Label {
                                text: taskModel.count.toString()
                                font.bold: true
                                font.pixelSize: 28
                                color: primaryColor
                            }
                            
                            Label {
                                text: qsTr("Total Tasks")
                                font.pixelSize: 13
                                color: textSecondaryColor
                                font.weight: Font.Medium
                            }
                        }
                    }
                }
            }
            
            // Completed tasks card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                radius: 16
                color: surfaceColor
                
                DropShadow {
                    anchors.fill: parent
                    source: parent
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    color: "#10000000"
                }
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 8
                    
                    Row {
                        spacing: 12
                        
                        Rectangle {
                            width: 40
                            height: 40
                            radius: 20
                            color: successColor + "20"
                            
                            Text {
                                anchors.centerIn: parent
                                text: "✅"
                                font.pixelSize: 18
                            }
                        }
                        
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            
                            Label {
                                text: {
                                    var completed = 0;
                                    for (var i = 0; i < taskModel.count; i++) {
                                        if (taskModel.get(i).completed) completed++;
                                    }
                                    return completed.toString();
                                }
                                font.bold: true
                                font.pixelSize: 28
                                color: successColor
                            }
                            
                            Label {
                                text: qsTr("Completed")
                                font.pixelSize: 13
                                color: textSecondaryColor
                                font.weight: Font.Medium
                            }
                        }
                    }
                }
            }
            
            // Pending tasks card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                radius: 16
                color: surfaceColor
                
                DropShadow {
                    anchors.fill: parent
                    source: parent
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    color: "#10000000"
                }
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 8
                    
                    Row {
                        spacing: 12
                        
                        Rectangle {
                            width: 40
                            height: 40
                            radius: 20
                            color: warningColor + "20"
                            
                            Text {
                                anchors.centerIn: parent
                                text: "⏳"
                                font.pixelSize: 18
                            }
                        }
                        
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            
                            Label {
                                text: {
                                    var pending = 0;
                                    for (var i = 0; i < taskModel.count; i++) {
                                        if (!taskModel.get(i).completed) pending++;
                                    }
                                    return pending.toString();
                                }
                                font.bold: true
                                font.pixelSize: 28
                                color: warningColor
                            }
                            
                            Label {
                                text: qsTr("Pending")
                                font.pixelSize: 13
                                color: textSecondaryColor
                                font.weight: Font.Medium
                            }
                        }
                    }
                }
            }
        }

        // Filter tabs
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            radius: 12
            color: surfaceColor
            
            DropShadow {
                anchors.fill: parent
                source: parent
                verticalOffset: 2
                radius: 8
                samples: 17
                color: "#10000000"
            }
            
            Row {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 5
                
                Repeater {
                    model: [qsTr("All"), qsTr("Active"), qsTr("Completed")]
                    
                    Button {
                        width: (parent.width - parent.spacing * 2) / 3
                        height: parent.height
                        text: modelData
                        
                        property bool isActive: index === 0
                        
                        background: Rectangle {
                            radius: 8
                            color: parent.isActive ? primaryColor : "transparent"
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            font.pixelSize: 13
                            font.weight: Font.Medium
                            color: parent.isActive ? "white" : textSecondaryColor
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }

        // Tasks list with modern design
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 16
            color: surfaceColor
            
            DropShadow {
                anchors.fill: parent
                source: parent
                verticalOffset: 4
                radius: 12
                samples: 25
                color: "#10000000"
            }
            
            ScrollView {
                anchors.fill: parent
                anchors.margins: 15
                clip: true

                ListView {
                    id: taskList
                    model: taskModel
                    spacing: 12
                    
                    header: Item {
                        width: parent.width
                        height: 10
                    }
                    
                    footer: Item {
                        width: parent.width
                        height: 10
                    }

                    delegate: TaskItem {
                        width: taskList.width
                        taskTitle: model.title
                        taskDescription: model.description
                        taskCompleted: model.completed
                        taskPriority: model.priority
                        taskDueDate: model.dueDate
                        taskCategory: model.category || ""

                        onToggleCompleted: {
                            taskModel.setProperty(index, "completed", !model.completed);
                        }

                        onDeleteTask: {
                            taskModel.remove(index);
                        }
                    }
                    
                    // Empty state
                    Rectangle {
                        visible: taskModel.count === 0
                        anchors.centerIn: parent
                        width: parent.width * 0.6
                        height: 200
                        color: "transparent"
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 20
                            
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "📝"
                                font.pixelSize: 64
                            }
                            
                            Label {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: qsTr("No tasks yet")
                                font.bold: true
                                font.pixelSize: 20
                                color: textColor
                            }
                            
                            Label {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: qsTr("Click 'Add Task' to create your first task")
                                font.pixelSize: 14
                                color: textSecondaryColor
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }
                }
            }
        }
    }

    // Add task dialog
    AddTaskDialog {
        id: addTaskDialog

        onTaskAdded: function(title, description, priority, dueDate, category) {
            taskModel.append({
                "title": title,
                "description": description,
                "completed": false,
                "priority": priority,
                "dueDate": dueDate,
                "category": category || "General"
            });
        }
    }
}
