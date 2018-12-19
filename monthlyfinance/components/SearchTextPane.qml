// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

Pane {
    id: searchPane
    // to see the topmost row in listview add this to parent (Page)
//        property bool keyboardVisible: Qt.inputMethod.visible
//        onKeyboardVisibleChanged: {
//            if(keyboardVisible) {
//                topPadding = 86
//            } else {
//                topPadding = 6
//            }
//        }
    property alias searchTextField: theSearchTextField
    // don't use text ! won't work on Android or iOS but on OSX
    // displayText is always working
    property alias currentSearchText: theSearchTextField.displayText

    topPadding: 0
    z: 1
    RowLayout {
        width: parent.width - 30
        IconActive {
            id:icon
            imageName: "search.png"
            MouseArea {
                anchors { fill: parent; margins: -10 }
                onClicked: wrapper.accepted()
            }
        }
        TextField {
            id: theSearchTextField
            selectByMouse: true
            Layout.fillWidth: true
            Layout.topMargin: 6
            Layout.leftMargin: 6
            placeholderText: qsTr("Search")
            // Keys.onReturnPressed: not used here
        }
        ButtonIconActive {
            visible: theSearchTextField.displayText.length > 0
            focusPolicy: Qt.ClickFocus
            imageName: "clear.png"
            onClicked: {
                theSearchTextField.text = ""
                theSearchTextField.forceActiveFocus()
            }
        }
    } // row

} // searchPane
