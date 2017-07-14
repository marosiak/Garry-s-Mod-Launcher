import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Page {
    id: a
    anchors.fill: parent
    signal installClicked
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
            text: "Counter Strike source"
        }
        CheckBox {
            text: "Half life 2 ep1 (optional)"
        }
        CheckBox {
            text: "Half life 2 ep2"
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
            text: "Install"
            onClicked: a.installClicked()
        }
        Button {
            text: "Cancel"
        }
    }
}
