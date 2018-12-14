// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

TextField {
    id: valueText
    selectByMouse: true
    validator: RegExpValidator{regExp: /\w+\@\w+(\.\w+)+/}
    color: acceptableInput ? Material.foreground : "Red"
    placeholderText: qsTr("guest@domain.com")
    wrapMode: Text.WordWrap
}
