import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import Qt.labs.folderlistmodel 2.11
import QtQuick.Window 2.11
import QtQuick.Controls.Material 2.4
import Qt.labs.platform 1.0

//import QtQml 2.2
import components 1.0
import assets 1.0

Popup {
    id:popup
    closePolicy: Popup.CloseOnPressOutside


    readonly property int _OpenFile: 0
    readonly property int _OpenFiles: 1
    readonly property int _SaveFile: 2

    // wrapper FileDialog and FolderListModel properties
    property string acceptLabel: qsTr("OK")
    property string currentFile: ""
    property var currentFiles
    property string defaultSuffix: ""
    property string file: ""
    property int fileMode: popup._OpenFile // filleMode enumerarion FileDialog
    property var files: []
    property alias folder: folderListModel.folder
    property alias nameFilters: folderListModel.nameFilters
    property string rejectLabel: qsTr("Cancel")

    property ListModel urls: ListModel {} // {url:'...'}

    property var selectModel: []

    property alias showDirs : folderListModel.showDirs
    property alias showDotAndDotDot: folderListModel.showDirsFirst
    property alias showFiles: folderListModel.showFiles
    property alias showHidden: folderListModel.showHidden
    property alias showDirsFirst: folderListModel.showDirsFirst
    property alias rootFolder: folderListModel.rootFolder

    // visual properties
    property string title: qsTr("Select File") //title.text
    property int popupWidth:  isLandscape ? parent.width * 0.60 : parent.width * 0.85
    property int pupoHeight:  isLandscape ? parent.height * 0.94 : parent.height * 0.85
    property bool isOK: false
    readonly property real textmargin: Utils.dp(Screen.pixelDensity, 8)
    readonly property real textSize: Utils.dp(Screen.pixelDensity, 10)
    readonly property real buttonHeight: Utils.dp(Screen.pixelDensity, 24)
    readonly property real rowHeight: Utils.dp(Screen.pixelDensity, 36)
    readonly property real toolbarHeight: Utils.dp(Screen.pixelDensity, 48)

    // signals
    signal fileSelected(string fileName)
    signal canceled()

    implicitWidth: popupWidth
    implicitHeight: pupoHeight

    x: parent.width/2 - popup.implicitWidth/2
    y: parent.height/2 - popup.implicitHeight/2

    modal: true
    z:2

    background: Rectangle {color: Style.cardAndDialogBackground}

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }
    }

    function currentFolder() {
        return folderListModel.folder;
    }

    function isFolder(fileName) {
        return folderListModel.isFolder(folderListModel.indexOf(folderListModel.folder + "/" + fileName));
    }

    function canMoveUp() {
        return folderListModel.folder.toString() !== myApp.rootFileSystem();
    }

    function onItemClick(fileName, index) {
        if(popup.fileMode == popup._OpenFiles &&
                isFolder(fileName) )
        {
            console.log("Enter Into Folder: " + fileName );
            urls.clear();
            goInFolder(index);
            return;
        }

        if(popup.fileMode == popup._OpenFile)
        {
            if(isFolder(fileName))
            {
//                console.log("Enter Into Folder: " + fileName );
                goInFolder(index);
                urls.clear();
            }
            else {
                urls.append({url:popup.filePath(index)});
                popup.file = popup.filePath(index);
                currentFile = folderListModel.folder + "/" + fileName;
                fileSelected(currentFile);
                popup.close();
            }
            return;
        }

        if (popup.fileMode == popup._SaveFile) {
            if(isFolder(fileName))
            {
                console.log("Click Folder: " + fileName );
                goInFolder(index);
            }
            else {
                // save file
            }
        }
    }

    function currentFileName()
    {
        return folderListModel.get(listFileSystem.currentIndex, "fileName")
    }

    function goInFolder(index){
        if (index >= 0 && index < folderListModel.count) {

            var fileURL = fileUrl(index);

            if(String(fileURL).length) {
                for(var i=0;i < selectModel.length; i++) selectModel.pop();
                folderListModel.folder = fileURL;
            }

//            console.log("goInFolder: " + fileURL);
        }
    }

    function fileUrl(index) {
        var fileURL = folderListModel.get(index, "fileURL");
        return fileURL;
    }

    function filePath(index) {
        var filePath = folderListModel.get(index, "filePath");
        return filePath;
    }

    FolderListModel {
        id:  folderListModel
        property string currentFileUrl
        folder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
        nameFilters: ["*.*"]
        showDirsFirst: true
        showDotAndDotDot:false
        showHidden: false
        sortField : FolderListModel.Name
        rootFolder: myApp.rootFileSystem()

        onFolderChanged: {
            for(var i=0;i < count; i++)
                selectModel.push(false)
//            console.log("onFolderChanged")
//            console.log("Folder: " + folder)
//            console.log("RootFolder: " + rootFolder)
//            console.log("Parent Folder: " + parentFolder)
//            console.log("Current File Name: " + get(listFileSystem.currentIndex, "fileName"))
        }
    }

    Page {
        id: pageRoot
        anchors.fill: parent
        header: headerDelegate.createObject(pageRoot)
        footer: footerDelegate.createObject(pageRoot)

        contentItem: ListView {
            id: listFileSystem
            //            currentIndex: -1
            spacing: 1
            focus: true
            clip:true
            model: folderListModel
            delegate: fileDelegate
            onCurrentIndexChanged: {
                //                console.log("Current Index Change: " + currentFileName())
            }
            onCurrentItemChanged: {
                //                console.log("Current Item Change: " + currentFileName())
            }
            //            ScrollBar.vertical: ScrollBar { } // FIMXE Set style
            ScrollIndicator.vertical: ScrollIndicator { }
        } // list
    } // pageRoot

    // row file delegate
    Component {
        id: fileDelegate               

        ItemDelegate {
            id: itemRootDelegate
            width: parent.width
            height: rowHeight
            RowLayout
            {
                anchors.fill: parent
                IconActive {
                    id: image
                    height: buttonHeight
                    width: height
//                    Layout.alignment: Qt.AlignVCenter
                    imageName: isFolder(fileNameText.text) ? "folder.png" : "insert_drive_file.png"
                } // icon
                Text {
                    id: fileNameText                    
                    Layout.alignment: Qt.AlignLeft                                       
                    Layout.fillWidth: true

                    color: flatButtonTextColor
                    text: fileName
                    elide: Text.ElideRight
//                    horizontalAlignment: Text.AlignLeft
                } //  text
                CheckBox {
                    id: radio
//                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Material.accent: Material.primary
                    visible: popup.fileMode == popup._OpenFiles
                }// radio
            }
            onClicked: {
               popup.onItemClick(fileName, index);
            }
        } // itemRootDelegate
    } // fileDelegate

    // page header
    Component {
        id: headerDelegate
        ToolBar {
            id: toolBar
            background: Rectangle {
                color: "#8535b3"
            }

            ColumnLayout {
                width: toolBar.width
                RowLayout {
                    Layout.fillWidth: true
                    ToolButton {
                        Image {
                            anchors.centerIn: parent
                            source: "qrc:/images/"+iconOnPrimaryFolder+"/arrow_back.png"
                        }
                        onClicked: {
                            if(canMoveUp) {
                                folderListModel.folder = folderListModel.parentFolder
                            }
                        }
                    }
                    LabelTitle {
                        id: title
                        text: popup.title
                        leftPadding: 6
                        rightPadding: 6
//                        elide: Text.ElideRight
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                        color: textOnPrimary
                    }
                }
                RowLayout {
                    Layout.fillWidth: true

                    LabelBody{
                        leftPadding: 6
                        rightPadding: 6
                        bottomPadding: 6
                        text: String(folderListModel.folder).replace("file://","")
                        elide: Text.ElideMiddle
                        color: textOnPrimary
                    }
                }
            }// cool
        } //  header
    }// headerDelegate

    // page footer
    Component {
        id: footerDelegate
        ToolBar {
            background: Rectangle{color: "transparent" }
            RowLayout {
                anchors.fill: parent
                ButtonFlat {
                    id: btnReject
                    Layout.fillWidth: true
                    Layout.preferredWidth: 3
                    text: popup.rejectLabel
                    textColor: Material.color(Material.Orange)
                    onClicked: {
                        popup.canceled()
                        popup.close()
                    }
                } // cancel button
                ButtonFlat {
                    id: btnAccept
                    Layout.fillWidth: true
                    Layout.preferredWidth: 2
                    text: popup.acceptLabel
                    textColor: primaryColor
                    onClicked: {
                        fileSelected(folderListModel.get(listFileSystem.currentIndex,
                                                         "fileName"))
                        popup.close()
                    }
                } // ok button
            }
        }
    }

    function init() {
        clear();
        popup.open();
    }

    function clear() {
        urls.clear()
    }

    Component.onCompleted: {
        console.log("FilePicker Popup onCompleted");
    }

    onOpened: {
        console.log("FilePicker onOpened: ");
        urls.clear();
        console.log("Clear Urls: " + urls.count);
    }
}// file picker

