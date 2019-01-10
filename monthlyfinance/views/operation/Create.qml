import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import components 1.0
import views.OperationType 1.0

BaseView {
    id: createView

    OperationType.Form {
        id: form
        anchor.fill:parent
    }

}
