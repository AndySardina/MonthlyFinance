// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
Item {
    implicitWidth: 8
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    // https://www.google.com/design/spec/components/dividers.html#dividers-types-of-dividers
    Rectangle {
        id: theRectangle
        width: 1
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: dividerOpacity
        color: dividerColor
    }
}
