// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4


ToolBar {
    id:toolBar
    property string title: "Title"
    property alias backButtonVisible: backButton.visible

    signal menuClicked()
    signal backClicked()

    contentHeight: toolButton.implicitHeight

    RowLayout {
        anchors.fill: parent
        ToolButton {
            id: toolButton
            visible: !backButton.visible
            focusPolicy: Qt.NoFocus
            Layout.alignment: Qt.AlignLeft
            IconActive {
                anchors.centerIn: parent
                imageName: "menu.png"
            }
            onClicked: {
                toolBar.menuClicked()
            }
        }// menu button

        ToolButton {
            id: backButton
            focusPolicy: Qt.NoFocus
            visible:false
            Layout.alignment: Qt.AlignLeft
            IconActive {
                anchors.centerIn: parent
                imageName: 'arrow_back.png'
            }
            onClicked: {
                toolBar.backClicked()
            }
        } // backButton

        Label {
            id:titleLabel
            text: toolBar.title
//            Layout.alignment: Qt.AlignHCenter
            //            anchors.centerIn: parent // FIXME Error
        }
    }
}
