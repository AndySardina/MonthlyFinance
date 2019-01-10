// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
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
        opacity: Style.dividerOpacity
        color: Style.dividerColor
    }
}
