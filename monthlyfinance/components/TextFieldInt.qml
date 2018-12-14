// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

TextField {
    id: valueText
    selectByMouse: true
    property int minValue: 0
    property int maxValue: 999
    validator: IntValidator{bottom: minValue; top: maxValue;}
    color: acceptableInput? Material.foreground : "Red"
    placeholderText: qsTr("%1...%2").arg(minValue).arg(maxValue)
    // ImhDigitsOnly: iOS: only digits, no . or , android: only allows digits and '.' but shows also + -
    inputMethodHints: Qt.ImhDigitsOnly
}
