import QtQuick 2.15
import QtQuick.Layouts 2.15

Item {
    ListModel {
        id: model
        ListElement {
            name: "Wi-Fi"
        }
        ListElement {
            name: "Bluetooth"
        }
        ListElement {
            name: "Theme"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        Image {
            source: "qrc:/icons/navigate_before_white.svg"
            Layout.alignment: Qt.AlignLeft
            MouseArea {
                anchors.fill: parent
                onClicked: stackView.pop()
            }
        }

        ListView {
            spacing: 10
            model: model
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 10
            delegate: Rectangle {
                    width: parent.width
                    height: 40
                    color: "black"
                    radius: Math.min(height, width) / 10
                    Text {
                        text: name
                        color: "white"
                        anchors.centerIn: parent
                        font.pointSize: 20
                    }
                    Image {
                        source: "qrc:/icons/navigate_next_white.svg"
                        anchors.right: parent.right
                    }
            }
        }
    }
}
