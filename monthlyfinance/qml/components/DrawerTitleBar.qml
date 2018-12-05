// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4


ToolBar {
    id:toolBar
    property string title: "Title"

    signal menuClicked()

    contentHeight: toolButton.implicitHeight   

    ToolButton {
        id: toolButton
//        text: stackView.depth > 1 ? "\u25C0" : "\u2630"
        text: "\u2630"
        font.pixelSize: Qt.application.font.pixelSize * 1.6
        onClicked: {
           toolBar.menuClicked()
        }
    }

    Label {
        id:titleLabel
//        text: "Title"
        text: toolBar.title
        anchors.centerIn: parent
    }
}
