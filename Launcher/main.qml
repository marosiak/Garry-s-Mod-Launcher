import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
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

    MainPage {
        id: mainPage
        onInstallClicked: {
            console.log("install clicked")
            secondWindow.show()
            root.hide()
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
}
