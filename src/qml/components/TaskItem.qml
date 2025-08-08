import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Rectangle {
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

    property string taskTitle: ""
    property string taskDescription: ""
    property bool taskCompleted: false
    property string taskPriority: ""
    property string taskDueDate: ""
    property string taskCategory: ""

    signal toggleCompleted()
    signal deleteTask()

    height: contentLayout.height + 30
    radius: 16
    color: taskCompleted ? successColor + "10" : surfaceColor
    border.width: 0
    
    // Subtle shadow
    DropShadow {
        anchors.fill: parent
        source: parent
        verticalOffset: 2
        radius: 6
        samples: 13
        color: taskCompleted ? successColor + "20" : "#10000000"
    }

    RowLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Custom checkbox
        Rectangle {
            width: 24
            height: 24
            radius: 12
            border.width: 2
            border.color: taskCompleted ? successColor : primaryColor + "60"
            color: taskCompleted ? successColor : "transparent"
            
            Rectangle {
                anchors.centerIn: parent
                width: 10
                height: 10
                radius: 5
                color: "white"
                visible: taskCompleted
            }
            
            Text {
                anchors.centerIn: parent
                text: "✓"
                font.pixelSize: 12
                font.bold: true
                color: "white"
                visible: taskCompleted
            }
            
            MouseArea {
                anchors.fill: parent
                onClicked: root.toggleCompleted()
                cursorShape: Qt.PointingHandCursor
            }
            
            Behavior on color {
                ColorAnimation { duration: 200 }
            }
            
            Behavior on border.color {
                ColorAnimation { duration: 200 }
            }
        }

        // Task content
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 12

            // Title and category row
            RowLayout {
                Layout.fillWidth: true
                spacing: 12
                
                Label {
                    text: taskTitle
                    font.bold: true
                    font.pixelSize: 18
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                    color: taskCompleted ? textSecondaryColor : textColor
                    font.strikeout: taskCompleted
                }
                
                // Category tag
                Rectangle {
                    visible: taskCategory.length > 0
                    radius: 12
                    color: primaryColor + "20"
                    border.color: primaryColor + "40"
                    border.width: 1
                    
                    Label {
                        anchors.centerIn: parent
                        anchors.margins: 8
                        text: taskCategory
                        font.pixelSize: 10
                        font.weight: Font.Medium
                        color: primaryColor
                    }
                }
            }

            // Description
            Label {
                text: taskDescription
                font.pixelSize: 14
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                color: taskCompleted ? textSecondaryColor : textSecondaryColor
                visible: taskDescription.length > 0
                lineHeight: 1.4
            }

            // Metadata row with modern design
            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                // Priority badge
                Rectangle {
                    radius: 16
                    color: {
                        switch(taskPriority) {
                            case qsTr("High"): return errorColor + "20";
                            case qsTr("Medium"): return warningColor + "20";
                            case qsTr("Low"): return successColor + "20";
                            default: return textSecondaryColor + "20";
                        }
                    }
                    border.color: {
                        switch(taskPriority) {
                            case qsTr("High"): return errorColor;
                            case qsTr("Medium"): return warningColor;
                            case qsTr("Low"): return successColor;
                            default: return textSecondaryColor;
                        }
                    }
                    border.width: 1
                    
                    Row {
                        anchors.centerIn: parent
                        anchors.margins: 8
                        spacing: 6
                        
                        Rectangle {
                            width: 6
                            height: 6
                            radius: 3
                            anchors.verticalCenter: parent.verticalCenter
                            color: {
                                switch(taskPriority) {
                                    case qsTr("High"): return errorColor;
                                    case qsTr("Medium"): return warningColor;
                                    case qsTr("Low"): return successColor;
                                    default: return textSecondaryColor;
                                }
                            }
                        }
                    
                        Label {
                            text: taskPriority
                            font.pixelSize: 11
                            font.weight: Font.Medium
                            anchors.verticalCenter: parent.verticalCenter
                            color: {
                                switch(taskPriority) {
                                    case qsTr("High"): return errorColor;
                                    case qsTr("Medium"): return warningColor;
                                    case qsTr("Low"): return successColor;
                                    default: return textSecondaryColor;
                                }
                            }
                        }
                    }
                }

                // Due date with icon
                Row {
                    spacing: 6
                    visible: taskDueDate.length > 0
                    
                    Text {
                        text: "📅"
                        font.pixelSize: 12
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    Label {
                        text: Qt.formatDate(new Date(taskDueDate), "MMM dd")
                        font.pixelSize: 12
                        font.weight: Font.Medium
                        anchors.verticalCenter: parent.verticalCenter
                        color: {
                            var today = new Date();
                            var due = new Date(taskDueDate);
                            var diffDays = Math.ceil((due - today) / (1000 * 60 * 60 * 24));

                            if (taskCompleted) return textSecondaryColor;
                            if (diffDays < 0) return errorColor; // Overdue
                            if (diffDays <= 3) return warningColor; // Due soon
                            return textSecondaryColor; // Normal
                        }
                    }
                }

                Item { Layout.fillWidth: true }
            }
        }

        // Actions with modern design
        Row {
            spacing: 8
            
            // Edit button
            Button {
                width: 36
                height: 36
                
                background: Rectangle {
                    radius: 18
                    color: parent.hovered ? primaryColor + "20" : "transparent"
                    border.color: parent.hovered ? primaryColor : "transparent"
                    border.width: 1
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: Text {
                    text: "✏️"
                    font.pixelSize: 14
                    color: parent.hovered ? primaryColor : textSecondaryColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                ToolTip.visible: hovered
                ToolTip.text: qsTr("Edit task")
                ToolTip.delay: 500
            }

            // Delete button
            Button {
                width: 36
                height: 36

                background: Rectangle {
                    radius: 18
                    color: parent.hovered ? errorColor + "20" : "transparent"
                    border.color: parent.hovered ? errorColor : "transparent"
                    border.width: 1
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }

                contentItem: Text {
                    text: "🗑️"
                    font.pixelSize: 14
                    color: parent.hovered ? errorColor : textSecondaryColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                ToolTip.visible: hovered
                ToolTip.text: qsTr("Delete task")
                ToolTip.delay: 500

                onClicked: {
                    deleteConfirmDialog.open();
                }
            }
        }
    }

    // Modern delete confirmation dialog
    Dialog {
        id: deleteConfirmDialog
        modal: true
        anchors.centerIn: parent
        width: 400
        
        background: Rectangle {
            radius: 16
            color: surfaceColor
            
            DropShadow {
                anchors.fill: parent
                source: parent
                verticalOffset: 8
                radius: 20
                samples: 41
                color: "#40000000"
            }
        }
        
        header: Rectangle {
            height: 60
            radius: 16
            color: errorColor + "10"
            
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.radius
                color: parent.color
            }
            
            Row {
                anchors.centerIn: parent
                spacing: 12
                
                Text {
                    text: "⚠️"
                    font.pixelSize: 24
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                Label {
                    text: qsTr("Delete Task")
                    font.bold: true
                    font.pixelSize: 18
                    color: textColor
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
        
        contentItem: Column {
            spacing: 20
            topPadding: 20
            bottomPadding: 20
            leftPadding: 20
            rightPadding: 20
            
            Label {
                text: qsTr("Are you sure you want to delete this task?")
                font.pixelSize: 14
                color: textColor
                wrapMode: Text.WordWrap
                width: parent.width - parent.leftPadding - parent.rightPadding
            }
            
            Rectangle {
                width: parent.width - parent.leftPadding - parent.rightPadding
                height: 60
                radius: 8
                color: backgroundColor
                
                Label {
                    anchors.centerIn: parent
                    anchors.margins: 15
                    text: '"' + taskTitle + '"'
                    font.bold: true
                    font.pixelSize: 13
                    color: textSecondaryColor
                    wrapMode: Text.WordWrap
                    width: parent.width - 30
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
        
        footer: Rectangle {
            height: 60
            radius: 16
            color: "transparent"
            
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.radius
                color: parent.parent.background.color
            }
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10
                
                Button {
                    Layout.fillWidth: true
                    text: qsTr("Cancel")
                    
                    background: Rectangle {
                        radius: 8
                        color: parent.hovered ? textSecondaryColor + "20" : "transparent"
                        border.color: textSecondaryColor + "40"
                        border.width: 1
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 13
                        font.weight: Font.Medium
                        color: textSecondaryColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: deleteConfirmDialog.reject()
                }
                
                Button {
                    Layout.fillWidth: true
                    text: qsTr("Delete")
                    
                    background: Rectangle {
                        radius: 8
                        color: parent.hovered ? errorColor : errorColor + "E0"
                        
                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                    }
                    
                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 13
                        font.weight: Font.Medium
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        deleteConfirmDialog.accept()
                        root.deleteTask()
                    }
                }
            }
        }
    }

    // Hover effect with smooth animations
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton

        onEntered: {
            root.color = taskCompleted ? successColor + "15" : surfaceColor
        }

        onExited: {
            root.color = taskCompleted ? successColor + "10" : surfaceColor
        }
    }
    
    // Smooth color transitions
    Behavior on color {
        ColorAnimation { duration: 200 }
    }
    
    // Scale animation on hover (subtle)
    scale: mouseArea.containsMouse ? 1.02 : 1.0
    
    Behavior on scale {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
