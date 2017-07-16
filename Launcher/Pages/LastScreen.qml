import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../Components"

ApplicationWindow {
    id: a
    width: 680
    height: 280
    visible: false
    maximumHeight : height
    maximumWidth : width
    minimumHeight : height
    minimumWidth : width
    property string headerLabel: "Recomended servers"
    Rectangle {
        anchors.fill: parent
        color: "#2c3e50"
        anchors.bottomMargin: 0
    }

    Grid {
        id: grid
        height: parent.height-60
        anchors.top: label.bottom
        anchors.topMargin: 16
        anchors.horizontalCenter: parent.horizontalCenter
        rows: 2
        columns: 2
        spacing: 10
        ServerBox {
            ipAdress: "193.70.4.1"
            name: qsTr("Perpheads RP - The best role play experience")
            imgSource: "../Background/5.jpg"
            onJoinClicked: unzipper.joinServer(ipAdress);
        }

        ServerBox {
            ipAdress: "193.70.4.1"
            name: "DG Dayz - Really cool distribution of popular Arma 2 mod"
            imgSource: "../Background/2.jpg"
            onJoinClicked: unzipper.joinServer(ipAdress);
        }
    }
    Rectangle {
        color: "#34495e"
        width: parent.width
        height: 60
    }

    Label {
        id: label
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: parent.width-40
        height: 60
        text: headerLabel
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: Text.WordWrap
    }
}
