import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import components 1.0
import Views.Currency 1.0
//import App.actions 1.0
import Flux 1.0

BaseView {
    id: createView
    name:"CurrencyViewPage"

    property alias modelId: form.modelId
    property alias modelObj: form.modelObj

    footer: CrudToolBar {
        id: crudButtons
//        visible: form.isModified
        onButtonClickedChanged: {
            if(buttonClicked == crudButtons.buttonUpdate) {
                ActionProvider.askRequesUpdateCurency(modelObj)
                return;
            }
            if(buttonClicked == crudButtons.buttonDelete) {
                ActionProvider.removeCurrency(modelObj.id)
                reset()
                return;
            }    
        }
    }

    Form {
        id: form       
        anchors.fill:parent
        title:'Currency'
    }
}
