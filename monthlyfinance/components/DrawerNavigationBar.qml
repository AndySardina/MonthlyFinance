import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import components 1.0

Drawer {
    id: drawer

    property alias destination:repeater.model
    onDestinationChanged:
    {
        console.log("destination")
        console.log(destination)
    }

    signal goToClicked(var index)

    Column {
        anchors.fill: parent

        Repeater {
            id:repeater
            delegate: DrawerNavigationButton {
//                isActive: index == appWindow.navigationIndex
                isActive: index == navigationIndex
                onIsActiveChanged:
                {
                    console.log('isActive: ' + index + ' ' + drawer.navigationIndex)
                }

                theIcon:iconName
                theText:title
                width: parent.width
                onClicked: {
                    console.log("onClicked: navigationIndex: " + index)
                    goToClicked(index)
                }
            }
        }
    }
}
