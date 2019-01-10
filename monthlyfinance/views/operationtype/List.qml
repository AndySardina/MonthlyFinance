// org.ingenii.cs
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0

import components 1.0
import assets 1.0

BaseView {
    id: listPage
    focus: true
    name: "OperationTypeList"
    bottomPadding: 24
    topPadding: 16

    background: Rectangle {
        color: "transparent"
    }

    ListModel {
        id:listModel
        ListElement {
            modelName:"Ingreso"
            modelDescritpion:"bla bla bla bla"
        }
        ListElement {
            modelName:"Egreso"
            modelDescritpion:"bla bla bla bla"
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

    // LIST ROW   S W I P E  DELEGATE
    Component {
        id: itemRowSwipeComponent
        SwipeDelegate {
            id: rowDelegate
            width: parent.width
            height: dataColumn.implicitHeight
            padding: 0
            text: " "
            down: pressed || swipe.complete
            background: Rectangle {
                color: "transparent"
            }

            NumberAnimation {
                id: removeFake
                target: rowDelegate
                property: "height"
                to: 0
                easing.type: Easing.InOutQuad
            }

            onClicked: {
                if(swipe.complete) {
                    // hide the Row from the List
                    //  removeFake.start()
                    return
                }
                if(swipe.position == 0) {

                    return
                }
            }

            // hint: if using without SwipeDelegate move onClicked code
            // TODO set dataColumn directly as contentItem (not yet because of a bug mentioned by J-P)
            ColumnLayout {
                id: dataColumn
                parent: rowDelegate.contentItem
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                RowLayout {
                    //                    spacing: 20
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50

                    LabelCaption {
                        Layout.fillWidth: true
                        padding: 0
                        //                        topPadding: 6
                        //                        leftPadding: 24
                        //                        rightPadding: 12
                        text:modelName
                        horizontalAlignment:Text.AlignHCenter
                        color: 'white'
                        opacity: 1
                        //                        Layout.alignment: Qt.AlignHCenter
                        //                        anchors.verticalCenter: parent.verticalCenter
                        //                                wrapMode: Label.WordWrap
                        //                                font.bold: true
                        //                                Layout.alignment: Qt.AlignHCenter
                        //                                anchors.horizontalCenter: parent.horizontalCenter
                    }

                    /*                    Item {
                        id: leftColumn
                        Layout.preferredWidth: 1
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        // important to get height resized automatically if remakrs is changed from elsewhere
                        implicitHeight: fiveLabels.implicitHeight
                        ColumnLayout {
                            id: fiveLabels
                            width: parent.width
                            spacing: 6
                            LabelCaption {
                                topPadding: 6
                                leftPadding: 24
                                rightPadding: 12
                                text:name
                                horizontalAlignment:Text.AlignHCenter
                                //                                wrapMode: Label.WordWrap
//                                font.bold: true
//                                Layout.alignment: Qt.AlignHCenter
//                                anchors.horizontalCenter: parent.horizontalCenter
                            } // label
                        } // 5 label rows in left column
                    }*/ // leftColumn
                } // end Row Layout
                HorizontalListDivider{
                    divColor: 'white'
                    divOpacity: 0.3
                }
            } // end Col Layout

            Component {
                id: behindComponent
                Item {
                    width: parent.width
                    height: parent.height
                    Rectangle {
                        anchors.fill: parent
                        color: Math.abs(swipe.position) > 0.3? Material.color(Material.Red, rowDelegate.pressed ? Material.Shade300 : Material.Shade500) : Material.color(Material.Grey)
                    }
                    ColumnLayout {
                        visible: Math.abs(swipe.position) == 1
                        width: parent.width
                        height: parent.height
                        LabelSubheading {
                            topPadding: 12
                            text: qsTr("Eliminar Categoria")
                            color: "white"
                            font.bold: true
                            horizontalAlignment: Qt.AlignHCenter
                        } // label
                        LabelBody {
                            bottomPadding: 12
                            text: qsTr("Deslizar para cancelar")
                            color: "white"
                            horizontalAlignment: Qt.AlignHCenter
                        } // label
                    } // col w Labels
                    Item {
                        id: imageItem
                        property bool isLeftPosition: swipe.position > 0 || Math.abs(swipe.position) == 1
                        height: parent.height
                        anchors.left: parent.left
                        anchors.right: parent.right
                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: imageItem.isLeftPosition? parent.left : parent.right
                            anchors.horizontalCenterOffset: imageItem.isLeftPosition? 42 : -42
                            height: 36
                            width: 36
                            source: "qrc:/images/white/x36/delete_sweep.png"
                        } // image
                    } // icon item
                } // behindItem
            } // behindComponent

            //            swipe.behind: behindComponent

        } // swipe rowDelegate
    } // orderRowSwipeComponent

    // LIST VIEW
    ListView {
        id: listView
        focus: true
        clip: true
        //         highlight: Rectangle {color: Material.listHighlightColor }
        currentIndex: -1
        anchors.fill: parent
        // setting the margin to be able to scroll the list above the FAB to use the Switch on last row
        bottomMargin: 40
        delegate: itemRowSwipeComponent
        model: listModel
        //        header: headerComponent
        // in Landscape header scrolls away
        // in protrait header always visible
        headerPositioning: Style.isLandscape? ListView.PullBackHeader : ListView.OverlayHeader
        ScrollIndicator.vertical: ScrollIndicator { }

    } // end listView

    BusyIndicator {
        id: bussy
        anchors.centerIn: parent
        running: false
        z:1
    }

    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log("Init done from CategoryListPage")
    }
    // called from Component.destruction
    function cleanup() {
        console.log("Cleanup done from CategoryListPage")
    }
    function handlerError(error) {
    }
} // end primaryPage
