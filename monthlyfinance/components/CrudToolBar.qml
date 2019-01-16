// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import assets 1.0

Pane {
    property string buttonDelete: "DELETE"
    property string buttonUpdate: "UPDATE"
    property string buttonRESET: "RESET"
    property string buttonClicked: buttonRESET
    anchors.right: parent.right
    anchors.left: parent.left
    padding: 0
    z: 2
    opacity: 0.80
    ColumnLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        RowLayout {
            spacing: 6
            Item {
                Layout.preferredWidth: 1
                Layout.fillWidth: true
            }

            Button {
                Layout.preferredWidth: 1
                Layout.fillWidth: true
                text: Style.isLandscape ?  qsTr("Update") : ''
                icon.source: 'qrc:/images/'+ Style.iconOnPrimaryFolder + '/ic_mode_edit.png'
                icon.color: Material.primary
                onClicked: {
                    buttonClicked = buttonUpdate
                }
            }
            Button {
                Layout.preferredWidth: 1
                Layout.fillWidth: true
                text: Style.isLandscape ?  qsTr("Delete") : ''
                icon.source: 'qrc:/images/'+ Style.iconOnPrimaryFolder + '/ic_delete.png'
                icon.color: Material.color(Material.Red, Material.Shade500)
                onClicked: {
                    buttonClicked = buttonDelete
                }
            }
        } // row layout

    } // col layout
    function reset() {
        buttonClicked = buttonRESET
    }
} // pane


