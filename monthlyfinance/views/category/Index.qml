// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtGraphicalEffects 1.0

import components 1.0
//import '../../components'
import assets 1.0
import Views.Currency 1.0 as Currency

BaseView {
    id: listPage

    focus: true
//    bottomPadding: 24
//    topPadding: 16
    name: "CurrencyIndexView"
    depth: currencyNavPane.depth

    // called immediately after Loader.loaded
    init: function() {
        console.log("Init done from CurrencyIndexView")
    }
    // called from Component.destruction
    cleanup: function() {
        console.log("Cleanup done from CurrencyIndexView")
    }

    StackView {
        id: currencyNavPane
        anchors.fill: parent
        focus: true

        initialItem:Currency.List{}

        Loader {
            id: currencyViewLoader
            property int categoryId: -1
            active: false
            visible: false
            source:"qrc:/currency/View.qml"
            onLoaded: {
                item.modelId = modelId
                currencyNavPane.push(item)
                item.init()
            }
        }

        Loader {
            id: currencyCreateLoader
            property int categoryId: -1
            active: false
            visible: false
            source:"qrc:/currency/View.qml"
            onLoaded: {
                item.modelId = modelId
                currencyNavPane.push(item)
                item.init()
            }
        }

        Loader {
            id: currencyUpdateLoader
            property int categoryId: -1
            active: false
            visible: false
            source:"qrc:/currency/View.qml"
            onLoaded: {
                item.modelId = modelId
                currencyNavPane.push(item)
                item.init()
            }
        }

        function pushDetailView(modelId) {
            currencyViewLoader.modelId = modelId
            currencyViewLoader.active = true
        }

        function pushCreateView(modelId) {
            currencyViewLoader.modelId = modelId
            currencyViewLoader.active = true
        }

        function pushUpdateView(modelId) {
            currencyViewLoader.modelId = modelId
            currencyViewLoader.active = true
        }

        function popOnePage() {

            if(currentItem.name === "CurrencyListView") {
                deleteCategory()
                return
            }
            if(currentItem.name === "CurrencyView") {
                var page = pop()
                categoryDetailPageLoader.active = false
                currencyNavPane.initialItem.init()
                return
            }
        } // popOnePage

    } // navPane

    ListModel {
        id:listModel
        ListElement {
            modelName:"USD"
            modelDescritpion:"Dolar Américano"
        }
        ListElement {
            modelName:"CUC"
            modelDescritpion:"Pesos Convertibles"
        }
        ListElement {
            modelName:"CUC"
            modelDescritpion:"Euro"
        }
    }

    // HEADER
    Component {
        id: headerComponent
        // placed the header controls inside a ToolBar
        // otherwise the header whill shine through to list content
        // while scrolling with ListView.OverlayHeader
        ToolBar {
            width: parent.width
            // default stackorder of 1 doesn't work
            z:2
            // here we set the background to list background
            background: Rectangle{color: Material.background}
            // now header controls work as expected
            ColumnLayout {
                width: parent.width
                RowLayout{
                    Layout.alignment: Qt.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    IconInactive {
                        imageName: modelData.icon
                    }
                    LabelSubheading {
                        text: qsTr("OperationTypeList: 7")
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
                HorizontalListDivider{}
            } // end Col Layout
        } // toolbar
    } // header component

    FloatingActionButton {
//        visible: currencyNavPane.depth == 0
        property string imageName: "/add.png"
        z: 2
        anchors.margins: 20
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        imageSource: "qrc:/images/" + Style.iconOnPrimaryDarkFolder + imageName
        backgroundColor: Style.primaryDarkColor
        onClicked: {
            if(currencyNavPane.depth == 1) {
                currencyNavPane.pushCreateView(-1)
            }
        }
    } // FAB

    function handlerError(error) {
    }
} // end primaryPage
