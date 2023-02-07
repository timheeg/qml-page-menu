import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    Material.theme: Material.Dark

    Action {
        id: openPageDrawer
        onTriggered: {
            mydrawer.open()
        }
    }

    footer: ToolBar {
        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                icon.source: "images/menu.png"
                action: openPageDrawer
            }
        }
    }

    PageDrawer {
        id: mydrawer
        visible: true
        interactive: true

        //
        // Icon Properties
        //
        iconTitle: "Test App"
        iconSource: "images/logo.png"
        iconSubtitle: qsTr("Hello, world!")

        //
        // Define the actions to take for each item
        // Drawer 5 and 6 are ignored, because they are used for
        // displaying a spacer and a separator
        //
        actions: {
            0: function() { console.log("Item 1 clicked!") },
            1: function() { console.log("Item 2 clicked!") },
            2: function() { console.log("Item 3 clicked!") },
            3: function() { console.log("Item 4 clicked!") }
        }

        //
        // Define the drawer items
        //
        items: ListModel {
            id: pagesModel

            ListElement {
                pageTitle: qsTr("Apple")
                pageIcon: "images/apple.svg"
                pageSource: "pages/APage.qml"
            }
            ListElement {
                pageTitle: qsTr("Banana")
                pageIcon: "images/banana.svg"
                pageSource: "pages/BPage.qml"
            }
            ListElement {
                pageTitle: qsTr("Cherry")
                pageIcon: "images/cherry.svg"
                pageSource: "pages/CPage.qml"
            }

            ListElement {
                pageTitle: qsTr("Durian")
                pageIcon: "images/durian.svg"
                pageSource: "pages/DPage.qml"
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane {
            id: pane

            Label {
                text: "Hello, world!"
                anchors.margins: 20
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.Wrap
            }
        }
    }
}
