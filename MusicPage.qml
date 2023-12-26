import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    ListModel {
        id: model
        ListElement {
            title: "Every Breath You Take"
            artist: "The Police"
        }
        ListElement {
            title: "Estranged"
            artist: "Guns N' Roses"
        }
        ListElement {
            title: "Everybody Wants to Rule The World"
            artist: "Tears For Fears"
        }
        ListElement {
            title: "More Than Words"
            artist: "Extreme"
        }
    }

    ColumnLayout {
        anchors.fill: parent
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
                    ColumnLayout {
                        Text {
                            text: title
                            color: "white"
                            font.pointSize: 12
                        }
                        Text {
                            text: artist
                            color: "white"
                            font.pointSize: 8
                        }
                    }
            }
        }
    }
}
