import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import components 1.0
import views.currency 1.0
import Flux 1.0

BaseView {
    id: createView
    name:"CurrencyCreatePage"

    property alias modelId: form.modelId
    property alias modelObj: form.modelObj

    footer: FooterCancelSave {
        id: footerButtons

        onButtonClickedChanged: {
            if(buttonClicked == footerButtons.buttonRESET) {
                return;
            }
            if(buttonClicked == footerButtons.buttonSAVE) {

                var formData = form.getData();
                ActionProvider.createCurrency(formData.name)
                reset()
                return;
            }
            if(buttonClicked === footerButtons.buttonCANCEL) {
                if(modelObj && modelObj.id > 0) {

                } else {
                    // NEW canceled
                }
                // GO back
            }
            footerButtons.reset();
            // want to go back to list now ?
            categoryNavPane.popOnePage();
        }
    }

    Form {
        id: form
        anchors.fill:parent
        title:'New Currency'
    }
}
