// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

//import components 1.0
import '../components'

ItemDelegate {
    id: myButton
    property bool isActive: false
    property string myIconFolder: Style.iconFolder
    property int counter: 0//navigationData[index].counter
    property color marker: 'red'//navigationData[index].marker
    property string theIcon: ''//icon
    property string theText: ''//title

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignHCenter
    focusPolicy: Qt.NoFocus
    //    height: 150
    width: myBar.width

    // Material.buttonPressColor
    Rectangle {
        //        visible: highlightActiveNavigationButton && myButton.isActive
        height: myButton.height
        width: myButton.width
        //        color:  Material.listHighlightColor
        color:  "white"
        opacity: 0.10
    }

    Rectangle {
        //        z:1
        visible: myButton.isActive
        height: myButton.height
        width: 5
        //        color:  Material.listHighlightColor
        //        opacity: 0.8
        color:  "white"
        //            opacity: 0.10
    }

    RowLayout {
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: buttonLabel
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: 24
            text: theText
            opacity: isActive ? 1.0 :  0.50
            //            color: isActive? primaryColor : dividerColor // flatButtonTextColor
            color: "white"
            font.weight: Font.Medium
        } // label
        IconInactive{
            id:iconActive
            visible: false
            imageName: theIcon
            currentIconFolder: Style.iconFolder
            horizontalAlignment: Image.AlignLeft
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.leftMargin: 16
            opacity: 0.5
        }
    } // row
} // myButton
