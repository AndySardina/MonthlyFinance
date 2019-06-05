import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import components 1.0

BaseView {
    id:rootHomePage
    title: qsTr("Home")
    name:'Home'

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
                Layout.preferredWidth: tool.preferredWidth
            }

            SearchTextPane{
                id:searchInput
                Layout.preferredWidth: tool.preferredWidth
                Material.background: Material.primary
            }
        }
    }

    Label {
        text: qsTr("You are on the home page.")
        anchors.centerIn: parent
    }
}
