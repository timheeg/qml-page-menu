import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

Drawer {
    id: drawer

    //
    // Default size options
    //
    implicitHeight: parent.height
    implicitWidth: Math.min(parent.width, parent.height) * 0.90

    //
    // Icon properties
    //
    property string iconTitle: ""
    property string iconSource: ""
    property string iconSubtitle: ""
    property size iconSize: Qt.size(24, 24)
    property color iconBGColorLeft: "#de6262"
    property color iconBGColorRight: "#ffb850"

    //
    // List model that generates the page selector
    // Options for selctor items are:
    //   - spacer: acts an expanding spacer between two items
    //   - pageTitle: the text to display
    //   - separator: if the element is a separator item
    //   - separatorText: optional text for the separator item
    //   - pageIcon: the image source to display
    //
    property alias items: listView.model
    property alias index: listView.currentIndex

    //
    // Execute appropriate action when the index changes
    //
    onIndexChanged: {
        var isSpacer = false
        var isSeparator = false
        var item = items.get(index)

        if (typeof(item) !== "undefined") {
            if (typeof(item.spacer) !== "undefined")
                isSpacer = item.spacer

            if (typeof(item.separator) !== "undefined")
                isSeparator = item.separator

            if (!isSpacer && !isSeparator)
                actions[index]()
        }
    }

    //
    // A list with functions that correspond with the index of each drawer item
    // provided with the \a pages property
    //
    // For a string-based example, check this SO answer:
    //   https://stackoverflow.com/a/26731377
    //
    // The only difference is that we are working with the index of each element
    // in the list view, for example, if you want to define the function to call
    // when the first item of the drawer is clicked, you should write:
    //
    //  actions: {
    //    0: function() {
    //        console.log("First item clicked")
    //    },
    //    1: function() {...},
    //    2: function() {...},
    //    ...
    //    n: function() {...},
    //  }
    //
    property var actions

    //
    // Main layout of the drawer
    //
    ColumnLayout {
        spacing: 0
        anchors.margins: 0
        anchors.fill: parent

        //
        // Icon controls
        //
        Rectangle {
            id: iconRect
            z: 1
            height: 120
            Layout.fillWidth: true

            Rectangle {
                anchors.fill: parent

                gradient: Gradient {
                    GradientStop { position: 0.0; color: iconBGColorLeft }
                    GradientStop { position: 1.0; color: iconBGColorRight }
                }
            }

            RowLayout {
                spacing: 16

                anchors {
                    fill: parent
                    centerIn: parent
                    margins: 16
                }

                Image {
                    source: iconSource
                    sourceSize: iconSize
                }

                ColumnLayout {
                    spacing: 8
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Item {
                        Layout.fillHeight: true
                    }

                    Label {
                        color: "#fff"
                        text: iconTitle
                        font.weight: Font.Medium
                        font.pixelSize: 16
                    }

                    Label {
                        color: "#fff"
                        opacity: 0.87
                        text: iconSubtitle
                        font.pixelSize: 12
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }

        //
        // Page selector
        //
        ListView {
            id: listView
            z: 1
            currentIndex: -1
            Layout.fillWidth: true
            Layout.fillHeight: true
            Component.onCompleted: currentIndex = 0

            delegate: DrawerItem {
                model: items
                width: parent.width
                pageSelector: listView

                onClicked: {
                    if(listView.currentIndex !== index)
                        listView.currentIndex = index
                        stackView.pop()
                        stackView.push(model.get(index).pageSource)

                    drawer.close()
                }
            }

            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }
}
