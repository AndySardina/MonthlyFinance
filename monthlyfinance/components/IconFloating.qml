// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4


Pane {
    id: root
    // image should be 24x24

    property alias imageName: icon.imageName

    // default: primaryColor
    property alias backgroundColor: buttonBackground.color

    property bool showShadow: false

    focusPolicy: Qt.NoFocus
    contentItem:Item {
        implicitHeight: 24
        implicitWidth: 24
        IconActive {
            id: icon
            anchors.centerIn: parent
        }
    }
    background:
        Rectangle {
        id: buttonBackground
        implicitWidth: 48
        implicitHeight: 48
        color: primaryColor
        radius: width / 2
//        opacity: root.pressed ? 0.75 : 1.0
//        layer.enabled: root.showShadow
//        layer.effect: DropShadow {
//            verticalOffset: 3
//            horizontalOffset: 1
//            color: dropShadow
//            samples: root.pressed ? 20 : 10
//            spread: 0.5
//        }
    }
}



