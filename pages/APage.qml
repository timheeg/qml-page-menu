import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

ScrollView {
    Column {
        spacing: 40
        width: parent.width

        Label {
            topPadding: 20
            width: parent.width
            wrapMode: Label.Wrap
            horizontalAlignment: Qt.AlignHCenter
            text: "This is the apple page."
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            smooth: true
            opacity: 1.0
            fillMode: Image.Pad
            sourceSize: Qt.size(128, 128)
            verticalAlignment: Image.AlignVCenter
            horizontalAlignment: Image.AlignHCenter
            source: "../images/apple.svg"
        }
    }
}
