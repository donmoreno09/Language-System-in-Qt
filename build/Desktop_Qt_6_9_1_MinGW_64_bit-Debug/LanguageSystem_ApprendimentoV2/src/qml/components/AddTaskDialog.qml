import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Dialog {
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

    width: 600
    height: 550
    modal: true
    
    signal taskAdded(string title, string description, string priority, string dueDate, string category)

    anchors.centerIn: parent
    
    background: Rectangle {
        radius: 20
        color: surfaceColor
        
        DropShadow {
            anchors.fill: parent
            source: parent
            verticalOffset: 12
            radius: 30
            samples: 61
            color: "#30000000"
        }
    }

    onOpened: {
        titleField.forceActiveFocus();
        titleField.selectAll();
    }

    function resetForm() {
        titleField.text = "";
        descriptionField.text = "";
        priorityCombo.currentIndex = 1; // Medium
        categoryField.text = "";
        dueDatePicker.selectedDate = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000); // +7 days
    }

    // Custom header
    header: Rectangle {
        height: 80
        radius: 20
        gradient: Gradient {
            GradientStop { position: 0.0; color: primaryColor }
            GradientStop { position: 1.0; color: secondaryColor }
        }
        
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.radius
            color: secondaryColor
        }
        
        Row {
            anchors.centerIn: parent
            spacing: 15
            
            Rectangle {
                width: 40
                height: 40
                radius: 20
                color: "#ffffff30"
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    anchors.centerIn: parent
                    text: "✨"
                    font.pixelSize: 20
                }
            }
            
            Column {
                anchors.verticalCenter: parent.verticalCenter
                
                Label {
                    text: qsTr("Create New Task")
                    font.bold: true
                    font.pixelSize: 22
                    color: "white"
                }
                
                Label {
                    text: qsTr("Add a new task to your list")
                    font.pixelSize: 13
                    color: "#ffffff80"
                }
            }
        }
    }

    contentItem: ScrollView {
        implicitWidth: 580
        implicitHeight: 400
        clip: true

        ColumnLayout {
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 25
            topPadding: 25
            bottomPadding: 25

            // Title field with modern styling
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                Label {
                    text: qsTr("Task Title") + " *"
                    font.bold: true
                    font.pixelSize: 15
                    color: textColor
                }

                TextField {
                    id: titleField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    placeholderText: qsTr("Enter task title...")
                    selectByMouse: true
                    font.pixelSize: 14

                    background: Rectangle {
                        color: parent.activeFocus ? primaryColor + "10" : backgroundColor
                        border.color: parent.activeFocus ? primaryColor : "#e2e8f0"
                        border.width: parent.activeFocus ? 2 : 1
                        radius: 12
                        
                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                        
                        Behavior on border.color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }
            }

            // Description field with modern styling
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                Label {
                    text: qsTr("Description")
                    font.bold: true
                    font.pixelSize: 15
                    color: textColor
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    clip: true

                    TextArea {
                        id: descriptionField
                        placeholderText: qsTr("Enter task description (optional)...")
                        wrapMode: TextArea.Wrap
                        selectByMouse: true
                        font.pixelSize: 14
                        leftPadding: 15
                        topPadding: 15
                        rightPadding: 15
                        bottomPadding: 15

                        background: Rectangle {
                            color: parent.activeFocus ? primaryColor + "10" : backgroundColor
                            border.color: parent.activeFocus ? primaryColor : "#e2e8f0"
                            border.width: parent.activeFocus ? 2 : 1
                            radius: 12
                            
                            Behavior on color {
                                ColorAnimation { duration: 200 }
                            }
                            
                            Behavior on border.color {
                                ColorAnimation { duration: 200 }
                            }
                        }
                    }
                }
            }
            
            // Category field
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                Label {
                    text: qsTr("Category")
                    font.bold: true
                    font.pixelSize: 15
                    color: textColor
                }

                TextField {
                    id: categoryField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    placeholderText: qsTr("Enter task category (optional)...")
                    selectByMouse: true
                    font.pixelSize: 14

                    background: Rectangle {
                        color: parent.activeFocus ? primaryColor + "10" : backgroundColor
                        border.color: parent.activeFocus ? primaryColor : "#e2e8f0"
                        border.width: parent.activeFocus ? 2 : 1
                        radius: 12
                        
                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                        
                        Behavior on border.color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }
            }

            // Priority and due date row with modern styling
            RowLayout {
                Layout.fillWidth: true
                spacing: 25

                // Priority
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    Label {
                        text: qsTr("Priority")
                        font.bold: true
                        font.pixelSize: 15
                        color: textColor
                    }

                    ComboBox {
                        id: priorityCombo
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        model: [qsTr("Low"), qsTr("Medium"), qsTr("High")]
                        currentIndex: 1 // Default to Medium
                        
                        background: Rectangle {
                            color: parent.hovered ? primaryColor + "10" : backgroundColor
                            border.color: parent.activeFocus ? primaryColor : "#e2e8f0"
                            border.width: parent.activeFocus ? 2 : 1
                            radius: 12
                            
                            Behavior on color {
                                ColorAnimation { duration: 200 }
                            }
                        }
                        
                        indicator: Text {
                            x: parent.width - width - 15
                            y: parent.topPadding + (parent.availableHeight - height) / 2
                            text: "▼"
                            font.pixelSize: 10
                            color: textSecondaryColor
                        }

                        delegate: ItemDelegate {
                            width: priorityCombo.width
                            height: 45
                            
                            background: Rectangle {
                                color: highlighted ? primaryColor + "20" : "transparent"
                                radius: 8
                            }
                            
                            contentItem: Row {
                                anchors.left: parent.left
                                anchors.leftMargin: 15
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 12

                                Rectangle {
                                    width: 12
                                    height: 12
                                    radius: 6
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: {
                                        switch(index) {
                                            case 0: return successColor; // Low - Green
                                            case 1: return warningColor; // Medium - Orange
                                            case 2: return errorColor; // High - Red
                                            default: return textSecondaryColor;
                                        }
                                    }
                                }

                                Text {
                                    text: modelData
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                    color: highlighted ? primaryColor : textColor
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                            highlighted: priorityCombo.highlightedIndex === index
                        }
                        
                        popup: Popup {
                            y: priorityCombo.height + 5
                            width: priorityCombo.width
                            height: Math.min(contentItem.implicitHeight + 20, 200)
                            padding: 10
                            
                            background: Rectangle {
                                color: surfaceColor
                                radius: 12
                                border.color: "#e2e8f0"
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
                                model: priorityCombo.popup.visible ? priorityCombo.delegateModel : null
                                currentIndex: priorityCombo.highlightedIndex
                                spacing: 2
                            }
                        }
                    }
                }

                // Due date with modern styling
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    Label {
                        text: qsTr("Due Date")
                        font.bold: true
                        font.pixelSize: 15
                        color: textColor
                    }

                    Button {
                        id: dueDatePicker
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50

                        property date selectedDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)

                        text: Qt.formatDate(selectedDate, "MMM dd, yyyy")
                        
                        background: Rectangle {
                            color: parent.hovered ? primaryColor + "10" : backgroundColor
                            border.color: parent.activeFocus ? primaryColor : "#e2e8f0"
                            border.width: parent.activeFocus ? 2 : 1
                            radius: 12
                            
                            Behavior on color {
                                ColorAnimation { duration: 200 }
                            }
                        }
                        
                        contentItem: Row {
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 10
                            
                            Text {
                                text: "📅"
                                font.pixelSize: 16
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            
                            Text {
                                text: parent.parent.text
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: textColor
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        onClicked: {
                            datePickerPopup.open();
                        }

                        Popup {
                            id: datePickerPopup
                            width: 350
                            height: 280
                            y: dueDatePicker.height + 5
                            
                            background: Rectangle {
                                color: surfaceColor
                                radius: 16
                                border.color: "#e2e8f0"
                                border.width: 1
                                
                                DropShadow {
                                    anchors.fill: parent
                                    source: parent
                                    verticalOffset: 8
                                    radius: 20
                                    samples: 41
                                    color: "#40000000"
                                }
                            }

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 20
                                spacing: 20

                                Label {
                                    text: qsTr("Select Due Date")
                                    font.bold: true
                                    font.pixelSize: 16
                                    color: textColor
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                GridLayout {
                                    Layout.fillWidth: true
                                    columns: 2
                                    rowSpacing: 15
                                    columnSpacing: 15

                                    Button {
                                        Layout.fillWidth: true
                                        text: qsTr("Today")
                                        
                                        background: Rectangle {
                                            radius: 8
                                            color: parent.hovered ? primaryColor + "20" : backgroundColor
                                            border.color: primaryColor + "40"
                                            border.width: 1
                                        }
                                        
                                        contentItem: Text {
                                            text: parent.text
                                            font.pixelSize: 13
                                            font.weight: Font.Medium
                                            color: textColor
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        
                                        onClicked: {
                                            dueDatePicker.selectedDate = new Date();
                                            datePickerPopup.close();
                                        }
                                    }

                                    Button {
                                        Layout.fillWidth: true
                                        text: qsTr("Tomorrow")
                                        
                                        background: Rectangle {
                                            radius: 8
                                            color: parent.hovered ? primaryColor + "20" : backgroundColor
                                            border.color: primaryColor + "40"
                                            border.width: 1
                                        }
                                        
                                        contentItem: Text {
                                            text: parent.text
                                            font.pixelSize: 13
                                            font.weight: Font.Medium
                                            color: textColor
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        
                                        onClicked: {
                                            dueDatePicker.selectedDate = new Date(Date.now() + 24 * 60 * 60 * 1000);
                                            datePickerPopup.close();
                                        }
                                    }

                                    Button {
                                        Layout.fillWidth: true
                                        text: qsTr("Next Week")
                                        
                                        background: Rectangle {
                                            radius: 8
                                            color: parent.hovered ? primaryColor + "20" : backgroundColor
                                            border.color: primaryColor + "40"
                                            border.width: 1
                                        }
                                        
                                        contentItem: Text {
                                            text: parent.text
                                            font.pixelSize: 13
                                            font.weight: Font.Medium
                                            color: textColor
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        
                                        onClicked: {
                                            dueDatePicker.selectedDate = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);
                                            datePickerPopup.close();
                                        }
                                    }
                                    
                                    Button {
                                        Layout.fillWidth: true
                                        text: qsTr("Next Month")
                                        
                                        background: Rectangle {
                                            radius: 8
                                            color: parent.hovered ? primaryColor + "20" : backgroundColor
                                            border.color: primaryColor + "40"
                                            border.width: 1
                                        }
                                        
                                        contentItem: Text {
                                            text: parent.text
                                            font.pixelSize: 13
                                            font.weight: Font.Medium
                                            color: textColor
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        
                                        onClicked: {
                                            dueDatePicker.selectedDate = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000);
                                            datePickerPopup.close();
                                        }
                                    }
                                }

                                Item { Layout.fillHeight: true }
                            }
                        }
                    }
                }
            }

            // Help text
            Label {
                Layout.fillWidth: true
                text: qsTr("* Required fields")
                font.pixelSize: 12
                color: textSecondaryColor
                Layout.topMargin: 10
            }

            Item { Layout.fillHeight: true }
        }
    }
    
    // Custom footer with modern buttons
    footer: Rectangle {
        height: 80
        radius: 20
        color: "transparent"
        
        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.radius
            color: surfaceColor
        }
        
        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            
            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                text: qsTr("Cancel")
                
                background: Rectangle {
                    radius: 12
                    color: parent.hovered ? textSecondaryColor + "20" : "transparent"
                    border.color: textSecondaryColor + "60"
                    border.width: 1
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    color: textSecondaryColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    resetForm()
                    root.reject()
                }
            }
            
            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                text: qsTr("Create Task")
                enabled: titleField.text.trim().length > 0
                
                background: Rectangle {
                    radius: 12
                    gradient: parent.enabled ? Gradient {
                        GradientStop { position: 0.0; color: primaryColor }
                        GradientStop { position: 1.0; color: secondaryColor }
                    } : null
                    color: parent.enabled ? "transparent" : textSecondaryColor + "40"
                    
                    DropShadow {
                        anchors.fill: parent
                        source: parent
                        verticalOffset: parent.parent.enabled ? 4 : 0
                        radius: 12
                        samples: 25
                        color: parent.parent.enabled ? primaryColor + "40" : "transparent"
                    }
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 14
                    font.weight: Font.Bold
                    color: parent.enabled ? "white" : textSecondaryColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    if (titleField.text.trim().length > 0) {
                        var dueDate = dueDatePicker.selectedDate.toISOString().split('T')[0];
                        taskAdded(
                            titleField.text.trim(),
                            descriptionField.text.trim(),
                            priorityCombo.currentText,
                            dueDate,
                            categoryField.text.trim()
                        );
                        resetForm();
                        root.accept();
                    }
                }
            }
        }
    }
}