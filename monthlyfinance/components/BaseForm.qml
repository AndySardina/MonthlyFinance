import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Pane {
    id:rootItem

    property bool isModified: false
    property int modelId: -2
    property var modelObj: null
    property string title: ''

    property var getData: function () {
        var data = {}
        return data;
    }
}
