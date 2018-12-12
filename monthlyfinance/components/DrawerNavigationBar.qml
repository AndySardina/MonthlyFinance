import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

Drawer {
    id: drawer

    property alias destination:repeater.model
    property int navigationIndex: -1
    onDestinationChanged:
    {
        console.log("destination")
        console.log(destination)
    }

    signal goToClicked(var url)

    Column {
        anchors.fill: parent

        Repeater {
            id:repeater
            delegate: ItemDelegate {
//                Component.onCompleted: {
//                    console.log(iconName)
//                }
//                display: AbstractButton.IconOnly
                text: title
                width: parent.width
                onClicked: {
                    goToClicked(url)
                }
            }
        }
    }
}
