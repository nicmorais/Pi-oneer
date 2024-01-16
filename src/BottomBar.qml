import QtQuick 2.15
import QtQuick.Layouts 1.15
import pioneer 1.0

Rectangle {
    id: bottomBarRect
    property alias volume: musicManager.volume

    function playTrack (track : TrackModel) {
        musicManager.play(track)
    }

    function show() {
        if(state !== "visible") {
            state = "visible"
        }
    }
    function hide() {
        if(state !== "hidden") {
            state = "hidden"
        }
    }

    Behavior on anchors.bottomMargin {
        animation: NumberAnimation {
            duration: 600
            easing.type: Easing.OutBounce
        }
    }

    MusicPlayManager {
        id: musicManager
    }

    Rectangle {
        id: progressLine
        width:  musicManager.position / parent.width
        height: 3
        color: "blue"
    }

    RowLayout {
        anchors.centerIn: parent

        Image {
            id: playIcon
            source: "qrc:/icons/pause.svg"

            MouseArea {
                anchors.fill: parent
                onClicked: () =>{
                           if(musicManager.status === "playing") {
                                musicManager.pause()
                               } else {
                                musicManager.resume()
                               }
                           }
            }
            states: [
                State {
                    name: "playing"
                    when: musicManager.status === "playing"
                    PropertyChanges {
                        playIcon.source: "qrc:/icons/pause.svg"
                    }
                },
                State {
                    name: "paused"
                    when: musicManager.status === "paused"
                    PropertyChanges {
                        playIcon.source: "qrc:/icons/play_arrow.svg"
                    }
                }
            ]
        }
        Text {
            text: musicManager.currentTrack.title
        }
    }

    states: [
        State {
            name: "visible"
            when: parent.y > 0
            PropertyChanges {
                target: bottomBarRect
                anchors.bottomMargin: 0
            }
        },
        State {
            name: "hidden"
            when: parent.y < 0
            PropertyChanges {
                target: bottomBarRect
                anchors.bottomMargin: -bottomBarRect.height * 1
            }
        }
    ]

}
