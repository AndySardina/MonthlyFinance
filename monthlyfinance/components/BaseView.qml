import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Page {
    id:basePage
    property string name: ""
    property int depth: -1 // for view with stack view

    // triggered from BACK KEYs:
    // a) Android system BACK
    // b) Back Button from TitleBar
    property var goBack: function () {
        // check if goBack is allowed
    }

    property var aboutShareConten: function(){

    }

    property var aboutSelectConten: function(){
    }

    property var init: function() {
        console.log("Init done from " + name)
    }

    property var cleanup: function() {
        console.log("Cleanup done from " + name)
    }

    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log("Init done from " + basePage.name)
    }
    // called from Component.destruction
    function cleanup() {
        console.log("Cleanup done from " + basePage.name)
    }

}// end base page
