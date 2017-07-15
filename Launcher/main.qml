import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import "./Pages/"

ApplicationWindow {
    id: root
    visible: true
    width: 300
    height: 200
    maximumHeight : height
    maximumWidth : width
    minimumHeight : height
    minimumWidth : width
    title: qsTr("Select")
    Connections {
        target: downloader
        onProgressRecived: {
            console.log(curr+"/"+max)
            downloadingPage.progressFrom = 0
            downloadingPage.progressTo = 100
            downloadingPage.progressValue = (curr/max)*100
        }
    }

    MainPage {
        id: mainPage
        onInstallClicked: {
            secondWindow.show()
            root.hide()
            downloader.setDownloadUrl("http://7grid.net/gmod/css.zip");
            downloader.setDownloadName("css"); // name of folder
            downloader.setSteamFolder(folderDialog.currentFolder)
            downloader.startDownloading()
        }
        onSetDirClicked: {
            folderDialog.visible = true
        }
    }
    Window {
        id: secondWindow
        visible: false
        width: 840
        height: 480
        maximumHeight : height
        maximumWidth : width
        minimumHeight : height
        minimumWidth : width
        title: qsTr("Launcher")
        DownloadingPage {
            id: downloadingPage
        }
    }

    FolderDialog {
        id: folderDialog
        title: qsTr("Please choose a dir")
        currentFolder: "file:///C:/Program Files (x86)/Steam"
        onAccepted: {
            console.log("You chose: " + folderDialog.folder)
        }
        onRejected: {
            console.log("Canceled")
        }
    }
}
