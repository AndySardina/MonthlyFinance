import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import components 1.0
import Views.OperationType 1.0

BaseView {
    id: createView
    name:"OperatiornTypeCreate"

    footer: FooterCancelSave {
        id: footerButtons
        visible: isModified
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
    }
}
