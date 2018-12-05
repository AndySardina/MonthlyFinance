import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11

import "../components"
//import "../../js/moment.min.js" as Moment

Page {
    id:rootHomePage
    title: qsTr("Home")

    header: ToolBar{
        id:tool
        //         background: Rectangle {border.color: 'red'}
        property int preferredWidth: width /  4
        RowLayout{
            Layout.fillWidth: true
            ComboBox {
                id:categories
                model: ['Todos','Comida','Ropa', 'Miselania','Salario','Otros']
                Layout.leftMargin: 16
                editable: true
                Layout.preferredWidth: tool.preferredWidth
                Layout.preferredHeight: 50
                currentIndex: 0
            }

            DateFieldInput {
                id:date
                viewPortParent:rootHomePage
                Layout.preferredWidth: tool.preferredWidth
                Layout.alignment:  Qt.AlignRight

            }

            TextField {
                id:input
                Layout.preferredWidth: tool.preferredWidth
                Layout.alignment:  Qt.AlignRight
                placeholderText: qsTr("search")
            }
        }
    }

    Label {
        text: qsTr("You are on the home page.")
        anchors.centerIn: parent
    }
}
