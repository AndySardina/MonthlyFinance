import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

import components 1.0
import views.OperationType 1.0

BaseView {
    id: createView

    OperationType.Form {
        id: form
        anchor.fill:parent
    }

}
