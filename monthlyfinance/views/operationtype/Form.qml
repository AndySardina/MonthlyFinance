import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

import components 1.0

BaseForm {
    id:form

    onModelIdChanged: {
        if(modelId > 0) {
//            dataManager.findModel(type, id) // async call to backend
        }
        else {
//            modelObj = dataManager.createModel(type, id) // return new intance QObject
        }
    }

    Flickable {
        id: flickable
        contentHeight: col.implicitHeight
        anchors.fill: parent

        Pane {
            id: rootPane
            anchors.fill: parent
            ColumnLayout {
                id:col
                anchors.right: parent.right
                anchors.left: parent.left
                LabelHeadline {
                    leftPadding: 10
                    text: qsTr("Tipo de Operación")
                }
                HorizontalDivider {}
                RowLayout {
                    LabelBodySecondary {
                        topPadding: 6
                        leftPadding: 10
                        rightPadding: 10
                        wrapMode: Text.WordWrap
                        text: qsTr("Nr")
                        Layout.preferredWidth: 1
                    }
                    LabelBody {
                        id: nrLabel
                        topPadding: 6
                        leftPadding: 10
                        rightPadding: 10
                        wrapMode: Text.WordWrap
                        text: modelId > 0 ? modelId : "-"
                        Layout.preferredWidth: 2
                    }
                } // nrLabel
                RowLayout {
                    LabelBodySecondary {
                        topPadding: 6
                        leftPadding: 10
                        rightPadding: 10
                        wrapMode: Text.WordWrap
                        text: qsTr("Nombre")
                        Layout.preferredWidth: 1
                    }
                    Pane {
                        topPadding: 6
                        leftPadding: 10
                        rightPadding: 10
                        Layout.fillWidth: true
                        Layout.preferredWidth: 2
                        TextField {
                            id: nameTextField
                            focus: true
                            anchors.fill: parent
                            topPadding: 6
                            leftPadding: 6
                            //rightPadding: 10
                            wrapMode: Text.WordWrap
                            placeholderText: qsTr("Nombre")
//                            text: categoryObj ? categoryObj.name : ""
                            // TODO feature request textChanging and textChanged - per ex trim
                            //Layout.fillWidth: true
                            //Layout.preferredWidth: 2
                        } // remarksTextField
                    } // nameTextField
                } // row nameTextField
                RowLayout {
                    Layout.fillWidth: true
                    LabelBodySecondary {
                        topPadding: 6
                        leftPadding: 10
                        rightPadding: 10
                        wrapMode: Text.WordWrap
                        text: qsTr("Descripción")                        
                        Layout.preferredWidth: 1

                    }
                    Pane {
                        topPadding: 6
                        leftPadding: 10
                        rightPadding: 10
                        Layout.fillWidth: true
                        Layout.preferredWidth: 2
                        TextAreaRow{
                            id: texArea
                            elevation: 3
                            anchors.fill: parent
//                            text:contestObj ? contestObj.description : ""
                        }
                    } // textField
                } // row textArea
            } // col layout
        } // root
        ScrollIndicator.vertical: ScrollIndicator { }
    } // flickable
}
