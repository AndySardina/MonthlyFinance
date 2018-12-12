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

    contentHeight: toolButton.implicitHeight

    ToolButton {
        id: toolButton
        visible: !backButton.visible && (appWindow.isLandscape || !appWindow.hasOnlyOneMenu)
        focusPolicy: Qt.NoFocus
        IconActive {
            anchors.centerIn: parent
            //                imageName: "menu.png"
            //                imageSize: 24
//            source: "qrc:/images/"+iconOnPrimaryFolder+"/menu.png"
            source: "qrc:/images/white"+"/menu.png"
        }
        onClicked: {
            toolBar.menuClicked()
        }
    }// menu button

    ToolButton {
        id: backButton
        focusPolicy: Qt.NoFocus
        visible:false
        Image {
            anchors.centerIn: parent
//            source: "qrc:/images/"+iconOnPrimaryFolder+"/arrow_back.png"
            source: "qrc:/images/white/arrow_back.png"
        }
        onClicked: {
            destinations.itemAt(navigationIndex).item.goBack()
        }
    } // backButton



    Label {
        id:titleLabel
        //        text: "Title"
        text: toolBar.title
        anchors.centerIn: parent
    }
}
