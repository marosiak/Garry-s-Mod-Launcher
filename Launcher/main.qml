import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import "./Pages/"
import "./Components"

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

        function nextDownload(typ) {
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
                unzippingWindow.show()
            }
        }
        Timer {
            property string typ
            id: downloadTimer
            interval: 1000; running: false; repeat: false
            onTriggered: root.nextDownload(typ)
        }
        Connections {
            id: connection
            target: downloader
            property bool cssDownloaded:false
            property bool hl2ep1Downloaded:false
            property bool hl2ep2Downloaded:false
            onProgressRecived: {

                downloadingPage.progressFrom = 0
                downloadingPage.progressTo = 100
                downloadingPage.progressValue = (curr/max)*100
                downloadingPage.currentDownloading = contentName
            }
            onDownloadingFinished: {
                downloadTimer.typ = typ
                downloadTimer.start();
            }
        }
        MainPage {
            id: mainPage
            onPlayClicked: {
                lastScreen.visible = true
                root.visible = false
            }

            onInstallClicked: {
                downloader.setSteamFolder(folderDialog.currentFolder)
                secondWindow.show()
                downloadingPage.restartSwipe()
                root.hide()
                if (mainPage.wantToInstallCss){
                    downloader.start("css");
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
    Unzipping {
        id: unzippingWindow
        path: folderDialog.currentFolder
        onWorkDone: {
            lastScreen.visible = true
            lastScreen.headerLabel = "Everything is done, you can close the window and play the game, I suggest you to join any server from below"
            unzippingWindow.visible = false
            secondWindow.visible = false
        }
    }
    LastScreen {
        id: lastScreen
    }

    FolderDialog {
        id: folderDialog
        title: qsTr("Please choose a dir")
        currentFolder: "file:///C:/Program Files (x86)/Steam"
    }
}
