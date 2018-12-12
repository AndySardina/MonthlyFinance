import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11

import components 1.0

Page {
    id:rootHomePage
    title: qsTr("Home")

    header: ToolBar{
        id:tool
        //         background: Rectangle {border.color: 'red'}
        property int preferredWidth: width /  4
        RowLayout{
            Layout.fillWidth: true
            anchors.horizontalCenter: parent.horizontalCenter
            ComboBox {
                id:categories
                model: ['Todos','Comida','Ropa', 'Miselania','Salario','Otros']
                Layout.leftMargin: 16
                editable: true
                Layout.preferredWidth: tool.preferredWidth
                Layout.preferredHeight: 50
                currentIndex: 0
            }

            DateRangeInput {
                id:date
                viewPortParent:rootHomePage
                Layout.preferredWidth: tool.preferredWidth //+ 50
//                Layout.alignment:  Qt.AlignRight

            }

            SearchInput
            {
                id:searchInput
                Layout.preferredWidth: tool.preferredWidth
//                Layout.alignment: Qt.AlignVCenter
//                Layout.alignment:  Qt.AlignRight
                placeholderText: 'search'
                focus: true
            }
        }
    }

    Label {
        text: qsTr("You are on the home page.")
        anchors.centerIn: parent
    }
}
