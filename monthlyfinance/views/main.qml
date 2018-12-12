import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11

import components 1.0

ApplicationWindow {
    id: appWindow

    property int firstActiveDestination: -1
    property int navigationIndex: firstActiveDestination
    onNavigationIndexChanged:{
        console.log(navigationIndex)
    }

    property string currentTitle: ""

    visible: true
    visibility: Window.Maximized
//    width: 640
//    height: 480
    minimumHeight: 600
    minimumWidth: 300

    title: qsTr("Monthly Finance")
//    Material.primary: Qt.black
//    Material.background: Qt.white
     background: Rectangle {color: 'white'}

    ListModel {
        id: navigationModel
        ListElement {
            title:qsTr("Home")
            url:"Home.qml"
            icon:"home.png"
            canGoBack:false
        }
        ListElement {
            title:qsTr("Register Operation")
            url:"CreateOperation.qml"
            icon:"home.png"
            canGoBack:false
        }
        ListElement {
            title:qsTr("Categories")
            url:"CreateCategory.qml"
            icon:"\ue88a"
            canGoBack:true
        }
        ListElement {
            title:qsTr("Report")
            url:"Report.qml"
            icon:"\ue88a"
            canGoBack:false
        }
        ListElement {
            title:qsTr("Settings")
            url:"Settings.qml"
            icon:"\ue88a"
            canGoBack:false
        }
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
            value: currentTitle
        }

        Connections {
            target: titleBarLoader.item
            onMenuClicked:{
//                if (stackView.depth > 1) {
//                    stackView.pop()
//                } else {
//                    drawer.open()
//                }
                 drawer.open()
            }

        }
    }

    DrawerNavigationBar {
        id: drawer
        width: appWindow.width * 0.66
        height: appWindow.height
        destination:navigationModel

        onGoToClicked: {
            console.log(url)
            if(stackView.depth > 1)
                stackView.replace(Qt.createComponent(url), Component.Asynchronous)
            else
                stackView.push(Qt.createComponent(url), Component.Asynchronous)
             drawer.close()
        }
    }

    StackView {
        id: stackView
        initialItem: Qt.createComponent('Home.qml')
        anchors.fill: parent
         background: Rectangle {color: 'white'}
        onCurrentItemChanged: {
            console.log("Main.qml stackView Index: " + stackView.depth)
            console.log(currentItem.title)
            console.log(titleBarLoader.item)
            console.log(stackView.currentItem)
            appWindow.currentTitle =  stackView.currentItem.title
            //            if(titleBarLoader.item)
            //                appWindow.currentTitle =  stackView.currentItem.title
            //                titleBarLoader.item.title = stackView.currentItem.title
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
