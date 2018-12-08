import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11


import '../../js/utils.js' as Utils

Pane {
    id:rootPane

    property var fromSelectedDate:null
    property var toSelectedDate:null
    property var datePicker:null
    property var viewPortParent: parent

    background: Rectangle {color: Material.primary}

    RowLayout {
        anchors.fill: parent
        IconActive {
//            id:
            imageName: 'calendar.png'
            imageSize: 18
//            source: 'qrc:/images/white/calendar.png'
//            Layout.preferredWidth: parent.width * 0.2

        }
        TextField {
            id:root
            Layout.preferredWidth: rootPane.width * 0.9

            inputMask: '00/00/0000 - 00/00/0000'
            readOnly: true
//            font.pixelSize: 14

            //     visible: datePickerLoader.status == Loader.Ready

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(datePicker == null)
                    {
                        var datePickerComponent = Qt.createComponent('DateRangePicker.qml')
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
                        fromSelectedDate = datePicker.fromSelectedDate
                        toSelectedDate = datePicker.toSelectedDate
                        root.text = Utils.moment(fromSelectedDate).format('DD/MM/YYYY') + ' - ' +  Utils.moment(toSelectedDate).format('DD/MM/YYYY')
                    }
                }
            }
        }
    }
}

