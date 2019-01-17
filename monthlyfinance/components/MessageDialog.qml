import QtQuick 2.11
import QtQuick.Controls 2.5

import components 1.0

Dialog {
    id:root
    property alias informativeText: informativeText.text


    LabelBody {
        id: informativeText
        anchors.fill: parent
        text: qsTr("")
    }
}
