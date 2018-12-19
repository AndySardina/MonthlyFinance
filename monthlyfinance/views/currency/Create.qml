import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

import components 1.0
//import '../../components'
import Views.Currency 1.0

BaseView {
    id: createView
    name:"OperatiornTypeCreate"

    property alias modelId: form.modelId

    footer: FooterCancelSave {
        id: footerButtons
        visible: form.isModified
        onButtonClickedChanged: {
            if(buttonClicked == footerButtons.buttonRESET) {
                return;
            }
            if(buttonClicked == footerButtons.buttonSAVE) {
                return;
            }
            if(buttonClicked === footerButtons.buttonCANCEL) {
                if(modelObj.id > 0) {

                } else {
                    // NEW canceled
                }
                // GO back
            }
            footerButtons.reset()
            // want to go back to list now ?
            categoryNavPane.popOnePage()
        }
    }

    Form {
        id: form
        anchors.fill:parent
        title:'New Currency'
    }
}
