// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

import assets 1.0

Item {
    height: 8
//    anchors.left: parent.left
//    anchors.right: parent.right
    property alias divColor: rect.color
    property alias divOpacity: rect.opacity
    // anchors.margins: 6
    // https://www.google.com/design/spec/components/dividers.html#dividers-types-of-dividers
    Layout.fillWidth: true
    Rectangle {
        id:rect
        width: parent.width
        height: 1
        opacity: Style.dividerOpacity
        color: Style.dividerColor
    }
}
