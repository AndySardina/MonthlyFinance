import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

import components 1.0
import assets 1.0

ApplicationWindow {
    id: appWindow

    property int firstActiveDestination: 0
    property int navigationIndex: firstActiveDestination
    property var navigationItem: navigationIndex >= 0 ? navigationModel.get(navigationIndex) : null
    //    property var navigationModel: navigationListModel
    //    property var navigationModel: MainStore.navigationModel
    property alias navigationModel: navigationListModel

    visible: true
    visibility: Window.Maximized

//    width: 640
//    height: 480
    minimumHeight: 600
    minimumWidth: 300


    ListModel {
        id: navigationListModel
        ListElement {
            title:qsTr("Home")
            url:"Home.qml"
            iconName:"home.png"
            canGoBack:false
        }
        ListElement {
            title:qsTr("Register Operation")
            url:"qrc:/operation/List.qml"
            iconName:"home.png"
            canGoBack:false
        }
        ListElement {
            title:qsTr("Categories")
            url:"qrc:/category/List.qml"
            iconName:"home.png"
            canGoBack:true
        }
        ListElement {
            title:qsTr("Operation Type")
            url:"qrc:/operationtype/List.qml"
            iconName:"tag.png"
            canGoBack:true
        }
        ListElement {
            title:qsTr("Currency")
            url:"qrc:/currency/Index.qml"
            iconName:"tag.png"
            canGoBack:true
        }
        ListElement {
            title:qsTr("Report")
            url:"../views/Report.qml"
            iconName:"home.png"
            canGoBack:false
        }
        ListElement {
            title:qsTr("Settings")
            url:"../views/Settings.qml"
            iconName:"home.png"
            canGoBack:false
        }
    }


    title: qsTr("Monthly Finance")
    background: Rectangle {color: 'white'}

    onNavigationIndexChanged:{
        console.log('onNavigationIndexChanged: ' + navigationIndex)
    }

    property bool isLandscape: width > height

    onIsLandscapeChanged: {
        Style.setIsLandscape(isLandscape)
        console.log('Style.isLandscape: ' + Style.isLandscape)
    }

    Component
    {
        id: titleBarComponent
        DrawerTitleBar {

        }
    }

    Loader {
        id:titleBarLoader
        sourceComponent: titleBarComponent
        asynchronous: true
        onLoaded: {
            appWindow.header = item
        }
        onStatusChanged: {
            console.log()
        }

        Binding {
            target: titleBarLoader.item
            property: 'title'
            value: navigationItem.title
        }
        Binding {
            target: titleBarLoader.item
            property: 'backButtonVisible'
            value: navigationItem.canGoBack && stackView.currentItem.depth > 1
        }

        Binding {
            target: titleBarLoader.item
            property: 'isDrawerNavBarOpen'
            value:  drawer.opened
        }

        Connections {
            target: titleBarLoader.item
            onMenuClicked:{
                drawer.open()
            }
            onBackClicked:{
                if (stackView.depth > 1 && navigationItem.canGoBack) {
                    stackView.currentItem.goBack()
                } else {
                    drawer.open()
                }
            }
        }
    }

    DrawerNavigationBar {
        id: drawer
        width: appWindow.width / 2
        destination:appWindow.navigationModel

        modal: !isLandscape

        Binding {
            when: appWindow.header !== null
            target: drawer
            property: 'y'
            value: titleBarLoader.item.height
        }

        Binding {
            when: appWindow.header !== null
            target: drawer
            property: 'height'
            value:  appWindow.height - titleBarLoader.item.height
        }

        onGoToClicked: {
            var url = navigationModel.get(index).url
            navigationIndex = index
            console.log("Go to: " + url)
            if(stackView.depth > 1)
                stackView.replace(Qt.createComponent(url), Component.Asynchronous)
            else
                stackView.push(Qt.createComponent(url), Component.Asynchronous)
            drawer.close()
        }
    }

    StackView {
        id: stackView
        initialItem: Qt.createComponent('../views/Home.qml')
        anchors.fill: parent
        background: Rectangle {color: 'white'}
        onCurrentItemChanged: {
            console.log("Main.qml stackView Index: " + stackView.depth)
            //            console.log(currentItem.title)
            //            console.log(titleBarLoader.item)
            //            console.log(stackView.currentItem)
        }
        // STACK VIEW TRANSITIONS
        //        replaceEnter: Transition {
        //            PropertyAnimation {
        //                property: "opacity"
        //                from: 0
        //                to:1
        //                duration: 300
        //            }
        //        }

        //        replaceExit: Transition {
        //            PropertyAnimation {
        //                property: "opacity"
        //                from: 1
        //                to:0
        //                duration: 300
        //            }
        //        }

        //        pushEnter: Transition {
        //            id: pushEnter
        //            ParallelAnimation {
        //                PropertyAction { property: "x"; value: pushEnter.ViewTransition.item.pos }
        //                NumberAnimation { properties: "y"; from: pushEnter.ViewTransition.item.pos + stackView.offset; to: pushEnter.ViewTransition.item.pos; duration: 400; easing.type: Easing.OutCubic }
        //                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 400; easing.type: Easing.OutCubic }
        //            }
        //        }
        //        popExit: Transition {
        //            id: popExit
        //            ParallelAnimation {
        //                PropertyAction { property: "x"; value: popExit.ViewTransition.item.pos }
        //                NumberAnimation { properties: "y"; from: popExit.ViewTransition.item.pos; to: popExit.ViewTransition.item.pos + stackView.offset; duration: 400; easing.type: Easing.OutCubic }
        //                NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 400; easing.type: Easing.OutCubic }
        //            }
        //        }

        //        pushExit: Transition {
        //            id: pushExit
        //            PropertyAction { property: "x"; value: pushExit.ViewTransition.item.pos }
        //            PropertyAction { property: "y"; value: pushExit.ViewTransition.item.pos }
        //        }
        //        popEnter: Transition {
        //            id: popEnter
        //            PropertyAction { property: "x"; value: popEnter.ViewTransition.item.pos }
        //            PropertyAction { property: "y"; value: popEnter.ViewTransition.item.pos }
        //        }

    }
}
