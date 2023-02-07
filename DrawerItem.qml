import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

ItemDelegate {
    //
    // Do not allow the user to click spaces and separators
    //
    enabled: !isSpacer(index) && !isSeparator(index)

    //
    // Alias to parent list view
    //
    property ListModel model
    property ListView pageSelector

    //
    // Returns true if \c spacer is defined and is equal to \c true
    //
    function isSpacer(index) {
        if (typeof (model.get(index).spacer) !== "undefined")
            return model.get(index).spacer

        return false
    }

    //
    // Returns true if \c link is defined and is equal to \c true
    //
    function isLink(index) {
        if (typeof (model.get(index).link) !== "undefined")
            return model.get(index).link

        return false
    }

    //
    // Returns true if \c separator is defined and is equal to \c true
    //
    function isSeparator(index) {
        if (typeof (model.get(index).separator) !== "undefined")
            return model.get(index).separator

        return false
    }

    //
    // Returns the icon for the drawer item
    //
    function iconSource(index) {
        if (typeof (model.get(index).pageIcon) !== "undefined")
            return model.get(index).pageIcon

        return false
    }

    //
    // Returns the title for the drawer item
    //
    function itemText(index) {
        if (typeof (model.get(index).pageIcon) !== "undefined")
            return model.get(index).pageIcon

        return false
    }

    //
    // Returns true if \c separatorText is correctly defined
    //
    function hasSeparatorText(index) {
        return isSeparator(index) && typeof(model.get(index).separatorText !== "undefined")
    }

    //
    // Decide if we should highlight the item
    //
    highlighted: ListView.isCurrentItem ? !isLink(index) : false


    //
    // Calculate height depending on the type of item
    //
    height: {
        if (isSpacer(index)) {
            var usedHeight = 0
            for (var i = 0; i < model.count; ++i) {
                if (!isSpacer(i)) {
                    if (!isSeparator(i) || hasSeparatorText(i))
                        usedHeight += 48
                    else
                        usedHeight += 8
                }
            }

            return Math.max(8, pageSelector.height - usedHeight)
        }

        if (enabled || hasSeparatorText(index))
            return 48

        return 8
    }

    //
    // Separator Layout
    //
    ColumnLayout {
        spacing: 8
        anchors.fill: parent
        visible: isSeparator(index)
        anchors.verticalCenter: parent.verticalCenter

        Item {
            Layout.fillHeight: true
        }

        Rectangle {
            height: 0.5
            opacity: 0.20
        }

        Label {
            opacity: 0.54
            font.pixelSize: 14
            font.weight: Font.Medium
            text: hasSeparatorText(index) ? separatorText : ""
        }

        Item {
            Layout.fillHeight: true
        }
    }

    //
    // Normal layout
    //
    RowLayout {
        spacing: 16
        anchors.margins: 16
        anchors.fill: parent
        visible: !isSeparator(index)

        Image {
            smooth: true
            opacity: 0.54
            fillMode: Image.Pad
            source: iconSource(index)
            sourceSize: Qt.size(24, 24)
            verticalAlignment: Image.AlignVCenter
            horizontalAlignment: Image.AlignHCenter
        }

        Item {
            width: 36 - (2 * spacing)
        }

        Label {
            opacity: 0.87
            font.pixelSize: 14
            text: itemText(index)
            Layout.fillWidth: true
            font.weight: Font.Medium
        }
    }
}
