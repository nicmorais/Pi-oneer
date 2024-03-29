import QtQuick 2.15
import QtQuick.Layouts 1.15
import pioneer 1.0

Item {
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
            spacing: 50
            model: MusicTableModel {id: musicModel}
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 10
            delegate: Rectangle {
                    width: parent.width
                    height: 40
                    color: "black"
                    radius: Math.min(height, width) / 15
                    ColumnLayout {
                        Text {
                            text: model.title
                            color: "white"
                            font.pointSize: 15
                        }
                        Text {
                            text: model.artist + " - " + model.album
                            color: "white"
                            font.pointSize: 12
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: bottomBar.playTrack(musicModel.getAtIndex(index))
                    }
            }
        }
    }
}
