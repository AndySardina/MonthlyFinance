// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

// Use swipe component
Item {
    id:root
    width: parent.width
    height: parent.height
    property alias text:headText.text
    property alias description:descriptionLabel.text
    Rectangle {
        anchors.fill: parent
        color: Math.abs(swipe.position) > 0.3? Material.color(Material.Red, rowDelegate.pressed ? Material.Shade300 : Material.Shade500) : Material.color(Material.Grey)
    }
    ColumnLayout {
        visible: Math.abs(swipe.position) == 1
        width: parent.width
        height: parent.height
        LabelSubheading {
            id:headText
            topPadding: 12
            text: qsTr("Set Text Here")
            color: "white"
            font.bold: true
            horizontalAlignment: Qt.AlignHCenter
        } // label
        LabelBody {
            id:descriptionLabel
            bottomPadding: 12
            text: qsTr("Deslizar para cancelar")
            color: "white"
            horizontalAlignment: Qt.AlignHCenter
        } // label
    } // col w Labels
    Item {
        id: imageItem
        property bool isLeftPosition: swipe.position > 0 || Math.abs(swipe.position) == 1
        height: parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        Image {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: imageItem.isLeftPosition? parent.left : parent.right
            anchors.horizontalCenterOffset: imageItem.isLeftPosition? 42 : -42
            height: 36
            width: 36
            source: "qrc:/images/white/x36/delete_sweep.png"
        } // image
    } // icon item
} // behindItem

