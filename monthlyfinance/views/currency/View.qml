import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import components 1.0
import Views.Currency 1.0
import Flux 1.0

BaseView {
    id: createView
    name:"CurrencyViewPage"

    property alias modelId: form.modelId
    property alias modelObj: form.modelObj

    footer: CrudToolBar {
        id: crudButtons

        onButtonClickedChanged: {
            if(buttonClicked == crudButtons.buttonUpdate) {
                ActionProvider.askRequesUpdateCurency(modelObj)
                return;
            }

            if(buttonClicked == crudButtons.buttonDelete) {
                deleteMsgDialog.open()
                reset()
                return;
            }
        }
    }

    MessageDialog {
        id: deleteMsgDialog
        anchors.centerIn: parent
        title:qsTr("Delete Confirmation")
        informativeText: qsTr("Do you want to delete this currency?")
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted:{
            ActionProvider.removeCurrency(modelObj.id)
        }
    }

    Form {
        id: form
        anchors.fill:parent
        title:'Currency'
    }
}
