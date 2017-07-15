import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Page {
    id: a
    anchors.fill: parent
    signal installClicked
    signal setDirClicked
    property bool wantToInstallCss: cb1.checked
    property bool wantToInstallHl2ep1: cb2.checked
    property bool wantToInstallHl2ep2: cb3.checked
    function isSomethingChecked(){
        if (wantToInstallCss == true || wantToInstallHl2ep1 == true || wantToInstallHl2ep2 == true) {
            installButton.visible = true
            installButton.enabled = true
        }
        if (wantToInstallCss == false && wantToInstallHl2ep1 == false && wantToInstallHl2ep2 == false) {
            installButton.enabled = false
        }
    }
    Timer {
        interval: 50; running: true; repeat: true
        onTriggered: a.isSomethingChecked()
    }
    Rectangle {
        anchors.fill: parent
        color: "#2c3e50"
    }
    Column {
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        CheckBox {
            id: cb1
            text: "Counter Strike source"
            checked: true
        }
        CheckBox {
            id: cb2
            text: "Half life 2 ep1 (optional)"
            checked: false
        }
        CheckBox {
            id: cb3
            text: "Half life 2 ep2"
            checked: true
        }
    }
    Row {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
        layoutDirection: Qt.RightToLeft
        spacing: 6
        Button {
            id: installButton
            text: "Install"
            onClicked: a.installClicked()
        }
        Button {
            id: button
            text: qsTr("Set steam DIR")
            onClicked: a.setDirClicked()

        }
        Button {
            text: "Cancel"
            onClicked: Qt.quit()
        }
    }
}
