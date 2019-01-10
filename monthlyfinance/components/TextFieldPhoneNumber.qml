// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

TextField {
    id: valueText
    selectByMouse: true
    validator: RegExpValidator{regExp: /\d+/} // FIXME TERMINAR VALIDATOR
    color: acceptableInput ? Material.foreground : "Red"
    placeholderText: qsTr("52231415")
    wrapMode: Text.WordWrap
}
