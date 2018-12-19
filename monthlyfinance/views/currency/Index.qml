// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtGraphicalEffects 1.0

import components 1.0
//import '../../components'
import assets 1.0
//import Views.Currency 1.0 as Currency

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

   goBack: function () {
        currencyNavPane.popOnePage()
    }


    StackView {
        id: currencyNavPane
        anchors.fill: parent
        focus: true

        initialItem:List{}

        Loader {
            id: viewLoader
            property int modelId: -1
            active: false
            visible: false
            source:"qrc:/currency/View.qml"
            onLoaded: {
                item.modelId = modelId
                currencyNavPane.push(item)
                item.init()
            }
        }

        function pushView(modelId, viewUrl) {
            viewLoader.modelId = modelId
            viewLoader.source = viewUrl
            viewLoader.active = true
        } 

        function popOnePage() {

            if(currencyNavPane.depth > 1) {
                var page = pop()
                viewLoader.active = false
                currencyNavPane.initialItem.init()
                return
            }
        } // popOnePage

    } // navPane

    FloatingActionMiniButton
    {
        visible:currencyNavPane.depth == 1
        property string imageName: "/add.png"
        z: 1
        anchors.margins: 20
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        imageSource: "qrc:/images/" + Style.iconOnPrimaryDarkFolder + imageName
        backgroundColor: Style.primaryDarkColor
        showShadow: true
        onClicked: {
            if(currencyNavPane.depth == 1) {
                currencyNavPane.pushView(-1,'qrc:/currency/Create.qml')
            }
        }
    }

//    FloatingActionButton {
////        visible: currencyNavPane.depth == 0
//        property string imageName: "/add.png"
//        z: 2
//        anchors.margins: 20
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        imageSource: "qrc:/images/" + Style.iconOnPrimaryDarkFolder + imageName
//        backgroundColor: Style.primaryDarkColor
//        onClicked: {
//            if(currencyNavPane.depth == 1) {
//                currencyNavPane.pushCreateView(-1)
//            }
//        }
//    } // FAB

    function handlerError(error) {
    }
} // end primaryPage
