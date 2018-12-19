// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtGraphicalEffects 1.0

import assets 1.0

Button {
    id: button
    // image should be 24x24
    property alias imageSource: contentImage.source
    // default: primaryColor
    property alias backgroundColor: buttonBackground.color
    property bool showShadow: false
    focusPolicy: Qt.NoFocus
    contentItem:
        Item {
        implicitHeight: 24
        implicitWidth: 24
        Image {
            id: contentImage
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
        opacity: button.pressed ? 0.75 : 1.0
        layer.enabled: button.showShadow
        layer.effect: DropShadow {
            verticalOffset: 3
            horizontalOffset: 1
            color: Style.dropShadow
            samples: button.pressed ? 20 : 10
            spread: 0.5
        }
    }
}
