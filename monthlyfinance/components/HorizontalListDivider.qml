// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

// special divider for list elements
// using height 1 ensures that it looks good if highlighted
Item {
    height: 1
//    anchors.left: parent.left
//    anchors.right: parent.right
    Layout.fillWidth: true
    property alias divColor: rect.color
    property alias divOpacity: rect.opacity

    Rectangle {
        id:rect
        width: parent.width
        height: 1
        opacity: Style.dividerOpacity
        color: Style.dividerColor
    }
}
