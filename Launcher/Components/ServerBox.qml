import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0


Item {
    id: item1
    width: 300
    height: 170
    property string ipAdress
    property string name
    property string imgSource
    signal joinClicked
    Image {
        id: img
        source: parent.imgSource
        anchors.fill: parent
        smooth: true
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: item1.joinClicked()
            onEntered: {
                blur.visible = true
                joinLabel.visible = true
                descLabel.visible = true
            }
            onExited:  {
                blur.visible = false
                joinLabel.visible = false
                descLabel.visible = false
            }
        }
    }
    GaussianBlur {
        id: blur
        anchors.fill: img
        source: img
        visible: false
        radius: 8
        samples: 16
    }
    Label {
        id: joinLabel
        visible: false
        text: qsTr("Join")
        font.pointSize: 26
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    Label {
        id: descLabel
        visible: false
        text: name
        width: parent.width-40
        wrapMode: Text.WordWrap
        font.pointSize: 12
        anchors.top: joinLabel.bottom
        anchors.topMargin: 3
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
