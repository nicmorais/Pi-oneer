import QtQuick 2.15
import QtQuick.Layouts 1.15
import pioneer 1.0

Item {
    ColumnLayout {
        anchors.fill: parent
        ListView {
            spacing: 50
            model: MusicTableModel{}
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 10
            delegate: Rectangle {
                    width: parent.width
                    height: 40
                    color: "black"
                    radius: Math.min(height, width) / 10
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
            }
        }
    }
}
