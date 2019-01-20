// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import components 1.0
import assets 1.0
import Flux 1.0

BaseView {
    id: listPage

    focus: true
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
            property var modelObj: null
            active: false
            visible: false
            asynchronous: true
            onLoaded: {
                console.log('onLoaded: ' + (status == Loader.Ready))
                console.log(source)
                if(status == Loader.Ready)
                {
                    item.modelId = modelId
                    item.modelObj = viewLoader.modelObj
                    currencyNavPane.push(item)
                    item.init()
                }
            }
        }

        function pushView(modelObj, viewUrl) {
            viewLoader.modelObj = modelObj
            viewLoader.source = viewUrl
            viewLoader.active = true
        }

        function popOnePage() {

            if(currencyNavPane.depth > 1) {
                var page = pop()
                viewLoader.active = false
                viewLoader.modelId = -1
                if(currencyNavPane.depth == 1) // inital list page
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
        anchors.rightMargin: 40

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        imageSource: "qrc:/images/" + Style.iconOnPrimaryDarkFolder + imageName
        backgroundColor: Style.primaryDarkColor
        showShadow: true
        onClicked: {
            if(currencyNavPane.depth == 1) {
                currencyNavPane.pushView(null,'qrc:/currency/Create.qml')
            }
        }
    }

    Connections {
        target:CurrencyStore
        onSaveCurrencyFinished:{
            if(!hasError){
                currencyNavPane.popOnePage()
                return;
            }
            // handlerError()
        }
        onAskRequestNewCurrency:{
            currencyNavPane.popOnePage()
            currencyNavPane.pushView(null,
                                     'qrc:/currency/Create.qml')
        }
        onAskRequesUpdateCurency:{
            console.log('onAskRequesUpdateCurency')
            currencyNavPane.popOnePage()
            currencyNavPane.pushView(currency,
                                     'qrc:/currency/Update.qml')
        }
        onReadCurrencyFinished: {
            console.log("onReadCurrencyFinished")
            if(!hasError){
                currencyNavPane.pushView(CurrencyStore.currency,
                                         'qrc:/currency/View.qml')
                return;
            }
        }
        onRemoveCurrencyFinished:{
            console.log('onRemoveCurrencyFinished')
            if(!hasError) {
                currencyNavPane.popOnePage()
            }
        }
    }

    function handlerError(error) {
    }
} // end primaryPage
