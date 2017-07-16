import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: a
    width: 400
    height: 200
    visible: false
    maximumHeight : height
    maximumWidth : width
    minimumHeight : height
    minimumWidth : width
    signal workDone
    property string path
    function show(){
        a.visible = true
        unzipper.setSteamPath(path)
        unzipper.unzip()
        a.workDone()
        // unzipping backed
    }
    Rectangle {
        anchors.fill: parent
        color: "#2c3e50"
    }

    Label {
        id: label
        width: 358
        height: 95
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("I'm unzipping your content, please give me around 3-5 mins, don't close the window.")
        wrapMode: Text.WordWrap
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
