// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

Button {
    id: button
    // default Image Size 24x24
    property alias imageName: theIcon.imageName
    property alias imageSize: theIcon.imageSize
    focusPolicy: Qt.NoFocus
    contentItem: IconActive {
        id: theIcon
    }
    background: Rectangle {
        id: buttonBackground
        implicitHeight: imageSize + 24
        implicitWidth: imageSize + 24
        color: button.pressed ? Style.accentColor : "transparent"
        opacity: button.pressed ? 0.12 : 1.0
    } // background
}
