// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

TextField {
    id: valueText
    selectByMouse: true
    validator: RegExpValidator{regExp: /\w+\@\w+(\.\w+)+/}
    color: acceptableInput ? Material.foreground : "Red"
    placeholderText: qsTr("guest@domain.com")
    wrapMode: Text.WordWrap
}
