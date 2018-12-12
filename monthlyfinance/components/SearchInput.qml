import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11

FocusScope {
    id: wrapper

    property alias text: input.text
    property alias placeholderText: input.placeholderText

    signal accepted
    //    signal textChanged

    TextField {
        id: input
        anchors.left: wrapper.left
        anchors.right:  icon.left
        focus: true
        verticalAlignment: Text.AlignVCenter

        font.pixelSize: 18
        onAccepted: wrapper.accepted()
        //            onTextChanged: wrapper.textChanged()
        placeholderText: 'search'
    }

    Image {
        id:icon
        anchors.right: wrapper.right
        source: "qrc:/images/white/search.png"
        MouseArea {
            anchors { fill: parent; margins: -10 }
            onClicked: wrapper.accepted()
        }
    }
}
