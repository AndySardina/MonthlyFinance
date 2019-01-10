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
            spacing: 20
            Item {
                Layout.preferredWidth: 1
                Layout.fillWidth: true
            }
            ButtonFlat {
                Layout.preferredWidth: 1
                text: qsTr("UPDATE")
                textColor: Style.primaryColor
                onClicked: {
                    buttonClicked = buttonUpdate
                }
            }
            ButtonFlat {
                Layout.preferredWidth: 1
                text: qsTr("DELETE")
                textColor: Style.accentColor
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


