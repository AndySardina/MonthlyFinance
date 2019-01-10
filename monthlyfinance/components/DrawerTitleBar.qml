// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12


ToolBar {
    id:toolBar
    property string title: "Title"
    property alias backButtonVisible: backButton.visible
    property bool isDrawerNavBarOpen: false

    signal menuClicked()
    signal backClicked()

    contentHeight: toolButton.implicitHeight

    states: [
        State {
            name: "drawerOpen"
            when: isDrawerNavBarOpen
            PropertyChanges {
                target: iconBack
                rotation: 90
            }
        }
    ]

    transitions: [
        Transition {
            to: "drawerOpen"
            reversible: true
            RotationAnimation {
                target:iconBack
                duration: 500
                direction: RotationAnimation.Counterclockwise
            }
        }
    ]

    RowLayout {
        anchors.fill: parent
        ToolButton {
            id: toolButton
            visible: !backButton.visible
            focusPolicy: Qt.NoFocus
            Layout.alignment: Qt.AlignLeft
            IconActive {
                id:iconBack
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
