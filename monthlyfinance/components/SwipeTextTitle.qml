// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ToolBar {
    id: titleToolBar
    property alias text: titleLabel.text
    property bool backToolButtonVisible: navPane.currentIndex > 0

    RowLayout {
        focus: false
        spacing: 6
        anchors.fill: parent
        ToolButton {
            enabled: backToolButtonVisible
            focusPolicy: Qt.NoFocus
            Image {
                id: backImageImage
                visible: backToolButtonVisible
                anchors.centerIn: parent
                source: "qrc:/images/"+iconOnPrimaryFolder+"/arrow_back.png"
            }
            onClicked: {
                navPane.onePageBack()
            }
        }
        LabelTitle {
            id: titleLabel
            text: "ekke"
            // leftPadding: 16
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            color: textOnPrimary
        }
        ToolButton {
            focusPolicy: Qt.NoFocus
            Image {
                id: buttonImage
                anchors.centerIn: parent
                source: "qrc:/images/"+iconOnPrimaryFolder+"/more_vert.png"
            }
            onClicked: {
                optionsMenu.open()
            }
            Menu {
                id: optionsMenu
                modal:true
                dim: false
                closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
                x: parent.width - width
                transformOrigin: Menu.TopRight
                MenuItem {
                    text: isDarkTheme? qsTr("Light Theme") : qsTr("Dark Theme")
                    onTriggered: {
                        themePalette = myApp.swapThemePalette()
                    }
                }
                MenuItem {
                    text: qsTr("Select Primary Color")
                    onTriggered: {
                        popup.selectAccentColor = false
                        popup.open()
                    }
                }
                MenuItem {
                    text: qsTr("Select Accent Color")
                    onTriggered: {
                        popup.selectAccentColor = true
                        popup.open()
                    }
                }
                onAboutToShow: {
                    appWindow.modalMenuOpen = true
                }
                onAboutToHide: {
                    appWindow.modalMenuOpen = false
                    appWindow.resetFocus()
                }
            } // end optionsMenu

        } // end ToolButton
    } // end RowLayout
} // end ToolBar


