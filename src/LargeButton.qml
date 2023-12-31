import QtQuick 2.15
import QtQuick.Layouts

Rectangle {
    id: baseRect
    radius: Math.min(width, height) / 20
    color: "lightblue"
    Layout.fillWidth: true
    Layout.fillHeight: true
    border.width: 5
    property alias title: title.text
    signal clicked()
    property alias icon: iconImage.source

    Image {
        id: iconImage
        mipmap: true
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: title
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: parent.height / 10
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: baseRect.clicked()
    }
}
