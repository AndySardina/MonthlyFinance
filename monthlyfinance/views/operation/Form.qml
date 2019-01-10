import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

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
        contentHeight: root.implicitHeight
        anchors.fill: parent

        Pane {
            id: root
            anchors.fill: parent
            ColumnLayout {
                anchors.right: parent.right
                anchors.left: parent.left
//                RowLayout {
//                    IconInactive {
//                        imageName: modelData.icon
//                        imageSize: 48
//                    }
//                    LabelSubheading {
                         // For acces from here, define property QQmlContestListModel in ContestNavigation
//                        text: qsTr("Concursos: ")+ dataManager.contestPropertyList.length
//                    }
//                }
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
//                        text: contestObj ? contestObj.id : ""
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
                        anchors.top: parent.top
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