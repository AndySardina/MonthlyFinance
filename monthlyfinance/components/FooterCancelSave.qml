// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

Pane {
    property string buttonCANCEL: "CANCEL"
    property string buttonSAVE: "SAVE"
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
                text: qsTr("Cancel")
                textColor: accentColor
                onClicked: {
                    buttonClicked = buttonCANCEL
                }
            }
            ButtonFlat {
                Layout.preferredWidth: 1
                text: qsTr("Save")
                textColor: primaryColor
                onClicked: {
                    buttonClicked = buttonSAVE
                }
            }
        } // row layout

    } // col layout
    function reset() {
        buttonClicked = buttonRESET
    }
} // pane


