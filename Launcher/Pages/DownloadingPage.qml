import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Page {
    id: page
    anchors.fill: parent
    SwipeView {
        id: view
        currentIndex: 1
        width: parent.width
        height: parent.height-rectangle.height
        clip: true
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            source: "../Background/0.jpg"
        }
        Image {
            source: "../Background/1.jpg"
        }
        Image {
            source: "../Background/2.jpg"
        }
        Image {
            source: "../Background/3.jpg"
        }
        Image {
            source: "../Background/4.jpg"
        }
    }
    Text {
        color: "#ffffff"
        text: "Downloading css.zip "+progressBar.value+"%"
        anchors.top: parent.top
        anchors.topMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

    }
    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Rectangle {
            implicitWidth: 8
            implicitHeight: 8

            //radius: width / 2
            radius: 0
            color: "#21be2b"

            opacity: index === indicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

            Behavior on opacity {
                OpacityAnimator {
                    duration: 100
                }
            }
        }
    }
    Rectangle {
        id: rectangle
        width: parent.width
        height: 85
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        color: "#2c3e50"
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, -48)
            end: Qt.point(0, 32)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "black" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }
        Row {
            id: row
            width: parent.width-24
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 14
            ProgressBar {
                id: progressBar
                width: parent.width-125
                anchors.verticalCenter: parent.verticalCenter
                value: 50
                from: 0
                to: 100
            }
            Button {
                text: qsTr("Cancel")
                anchors.verticalCenter: parent.verticalCenter
                width: 100
            }
        }
    }
}
