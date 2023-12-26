import QtQuick 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

Item {
    Clock{
        id: clock
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
    }

    GridLayout {
        anchors.centerIn: parent
        width: parent.width * 0.9
        height: parent.height * 0.8
        columnSpacing: 10
        rowSpacing: 10
        rows: 2
        columns: 3
        LargeButton {
            title: "Music"
            icon: "qrc:/icons/music_note.svg"
            onClicked: stackView.push("MusicPage.qml", StackView.Immediate)
        }
        LargeButton {
            title: "Radio"
            icon: "qrc:/icons/radio.svg"
        }
        LargeButton {
            title: "Aux"
            icon: "qrc:/icons/cable.svg"
        }
        LargeButton {
            title: "GPS"
            icon: "qrc:/icons/near_me.svg"
        }
        LargeButton {
            title: "Settings"
            icon: "qrc:/icons/settings.svg"
            onClicked: stackView.push("SettingsPage.qml")
        }
    }

    Rectangle {
        height: parent.height / 10
        width: parent.width
        anchors.bottom: parent.bottom
        Rectangle {
            id: progressLine
            width: parent.width / 3
            height: 3
            color: "blue"
        }

        RoundImage {
            id: disk
            source: "qrc:/icons/vinyl.jpg"
            height: parent.height * 1.2
            width: height
            anchors.leftMargin: 20
            anchors.left: parent.left
            anchors.bottomMargin: 10
            anchors.bottom: parent.bottom
        }
        RowLayout {
            anchors.centerIn: parent

            Image {
                id: playIcon
                source: "qrc:/icons/pause.svg"
                state: "playing"
                MouseArea {
                    anchors.fill: parent
                    onClicked: () =>{
                               if(playIcon.state === "playing") {
                                       playIcon.state = "stopped"
                                   } else {
                                       playIcon.state = "playing"
                                   }
                               }
                }
                states: [
                    State {
                        name: "playing"
                        PropertyChanges {
                            timer.running: true
                            playIcon.source: "qrc:/icons/pause.svg"

                        }
                    },
                    State {
                        name: "stopped"
                        PropertyChanges {
                            timer.running: false
                            playIcon.source: "qrc:/icons/play_arrow.svg"
                        }
                    }
                ]
            }
            Text {
                text: "Al Stewart - Year of The Cat"
            }
        }
    }


    Timer {
        id: timer
        interval: 50
        repeat: true
        onTriggered: {
            progressLine.width += 1
            disk.rotation += 5
        }
    }
}
