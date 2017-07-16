import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import "./Pages/"

Item {
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
        function nextDownload(typ){
            switch(typ) {
            case "css":
                connection.cssDownloaded = true;
                break;
            case "hl2ep1":
                connection.hl2ep1Downloaded = true;
                break;
            case "hl2ep2":
                connection.hl2ep2Downloaded = true;
                break;
            }
            var everythingDone = false
            if(mainPage.wantToInstallCss == true && connection.cssDownloaded == false){
                downloader.startDownloading("css");
                mainPage.wantToInstallCss = false
                everythingDone = false
            } else { everythingDone = true }
            if(mainPage.wantToInstallHl2ep1 == true && connection.hl2ep1Downloaded == false){
                downloader.startDownloading("hl2ep1");
                mainPage.wantToInstallHl2ep1 = false
                everythingDone = false
            } else { everythingDone = true }
            if(mainPage.wantToInstallHl2ep2 == true && connection.hl2ep2Downloaded == false){
                downloader.startDownloading("hl2ep2");
                mainPage.wantToInstallHl2ep2 = false
                everythingDone = false
            } else { everythingDone = true }
            if(everythingDone == true) {
                console.log("quest done")
            }
        }
        Timer {
            property string typ
            id: downloadTimer
            interval: 1000; running: false; repeat: false
            onTriggered: nextDownload(typ)
        }
        Connections {
            id: connection
            target: downloader
            property bool cssDownloaded:false
            property bool hl2ep1Downloaded:false
            property bool hl2ep2Downloaded:false
            onProgressRecived: {
                console.log(curr+"/"+max)

                downloadingPage.progressFrom = 0
                downloadingPage.progressTo = 100
                downloadingPage.progressValue = (curr/max)*100
                downloadingPage.currentDownloading = contentName
            }
            onDownloadingFinished: {
                console.log("finished "+typ)
                downloadTimer.typ = typ
                downloadTimer.start();
            }
        }
        MainPage {
            id: mainPage
            onInstallClicked: {
                downloader.setSteamFolder(folderDialog.currentFolder)
                secondWindow.show()
                root.hide()
                if (mainPage.wantToInstallCss){
                    downloader.startDownloading("css");
                }
                else if (mainPage.wantToInstallHl2ep1){
                    downloader.startDownloading("hl2ep1");
                }
                else if (mainPage.wantToInstallHl2ep2){
                    downloader.startDownloading("hl2ep2");
                }
            }
            onSetDirClicked: {
                folderDialog.visible = true
            }
        }
    }
    ApplicationWindow {
        id: secondWindow
        visible: false
        width: 840
        height: 480
        flags: Qt.Window
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
