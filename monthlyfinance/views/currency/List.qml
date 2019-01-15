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

    property bool selectAll: false

    signal newClicked()

    focus: true
    name: "CurrencyList"
    //    bottomPadding: 24
    //    topPadding: 16

    // called immediately after Loader.loaded
    init: function() {
        console.log("Init done from CurrencyListView")
        ActionProvider.listCurrency();
    }
    // called from Component.destruction
    cleanup: function() {
        console.log("Cleanup done from CurrencyListView")
    }

    Component.onCompleted:
    {
        init()
    }

    // HEADER
    Component {
        id: headerComponent
        // placed the header controls inside a ToolBar
        // otherwise the header whill shine through to list content
        // while scrolling with ListView.OverlayHeader
        ToolBar {
            width: parent.width
            //            height:listPage.height * 0.1
            // default stackorder of 1 doesn't work
            z:2
            // here we set the background to list background
            background: Rectangle{color: Material.background}
            // now header controls work as expected
            ColumnLayout {
                width: parent.width
                anchors.leftMargin: 16
                RowLayout{
                    Layout.fillWidth: true

                    CheckBox
                    {
                        id:slcAllCheckBox
                        text: Style.isLandscape ? 'Select all':''

                        Binding {
                            target: listPage
                            property: "selectAll"
                            value: slcAllCheckBox.checked
                        }
                    }

                    //                    Button {
                    //                        text: Style.isLandscape ? 'New' : ''
                    //                        icon.source: 'qrc:/images/'+ Style.iconOnPrimaryFolder + '/add.png'

                    //                        onClicked: {
                    //                            ActionProvider.askRequesNewCurency();
                    //                        }
                    //                    }
                    Button {
                        visible: slcAllCheckBox.checked
                        Behavior on visible {
                            PropertyAnimation { properties: "visible"; easing.type: Easing.InBounce;}
                        }

                        text: Style.isLandscape ? 'Delete' : ''
                        icon.source: 'qrc:/images/'+ Style.iconOnPrimaryFolder + '/ic_delete.png'
                        icon.color: Material.color(Material.Red, Material.Shade500)
                        onClicked: {
                            var currencies = new Array;
                            for(var i = 0 ;  listView.model.count > i; i++)
                            {
                                var curreny = listView.model.get(i)
                                console.log(curreny.id)
                                console.log(curreny)
                                currencies.push(curreny.id)
                            }

                            console.log(currencies)

//                            ActionProvider.removeBulkCurrency()
                        }
                    }

                    SearchTextPane{
                        id:searchInput
                        Layout.fillWidth: true
                        //                        Layout.alignment: Qt.AlignRight
                        //                        Layout.preferredWidth: tool.preferredWidth
                    }

                    //                    IconInactive {
                    //                        imageName: modelData.icon
                    //                    }
                    //                    LabelSubheading {
                    //                        text: qsTr("OperationTypeList: 7")
                    //                        Layout.alignment: Qt.AlignHCenter
                    //                    }
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
            highlighted: selectAll
            checked: highlighted
            onHighlightedChanged: {
                console.log("onHighlightedChanged: " + highlighted)
            }

            //            background: Rectangle {
            //                color: "transparent"
            //            }

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
                    //                      removeFake.start()
                    ActionProvider.removeCurrency(listView.model.get(index).id)
                    return
                }
                if(swipe.position == 0) {
                    //                    console.log(modelData)
                    //                    console.log(id)
                    console.log(listView.model.get(index).id)
                    ActionProvider.readCurrency(listView.model.get(index).id)
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
                        leftPadding: 16
                        //                        rightPadding: 12
                        text:name
                        color: 'white'
                        opacity: 1
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
                BehindDeleteComponent {
                    text: qsTr('Delete Currency: ') + name
                    description: qsTr("Deslizar para cancelar")
                } // behindComponent
            }

            swipe.behind: behindComponent

        } // swipe rowDelegate
    } // orderRowSwipeComponent

    // LIST VIEW
    ListView {
        id: listView
        //        focus: true
        //        clip: true
        //         highlight: Rectangle {color: Material.listHighlightColor }
        //        currentIndex: -1
        anchors.fill: parent
        // setting the margin to be able to scroll the list above the FAB to use the Switch on last row
        //        bottomMargin: 40
        delegate: itemRowSwipeComponent
        model: CurrencyStore.model
        header: headerComponent
        headerPositioning: ListView.OverlayHeader
        // in Landscape header scrolls away
        // in protrait header always visible
        //        headerPositioning: Style.isLandscape? ListView.PullBackHeader : ListView.OverlayHeader

        ScrollIndicator.vertical: ScrollIndicator { }

    } // end listView

    BusyIndicator {
        id: bussy
        anchors.centerIn: parent
        running: false
        z:1
    }

    function handlerError(error) {
    }
} // end primaryPage
