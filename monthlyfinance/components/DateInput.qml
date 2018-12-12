import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11

//import '../../js/utils.js' as Utils
import assets 1.0

TextField {
    id:root

    property var selectedDate:null
    property var datePicker:null
    property var viewPortParent: parent


    inputMask: '00/00/0000'
    readOnly: true

    //     visible: datePickerLoader.status == Loader.Ready

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(datePicker == null)
            {
                var datePickerComponent = Qt.createComponent('DatePicker.qml')
                if (datePickerComponent.status === Component.Ready) {
                    datePicker = datePickerComponent.createObject(viewPortParent, {'parent':viewPortParent})
                }
                else
                    console.log(datePickerComponent.errorString())
            }

            datePicker.open()
        }
    }

    Connections {
        id: con
        target: datePicker
        ignoreUnknownSignals: true
        onClosed:
        {
            if(datePicker.isOK)
            {
                selectedDate = datePicker.selectedDate
                console.log(selectedDate.toLocaleString());
                console.log(selectedDate.toDateString());
                console.log(selectedDate.toISOString());
                date.text = Utils.moment(selectedDate).format('DD/MM/YYYY')
            }
        }
    }
}
