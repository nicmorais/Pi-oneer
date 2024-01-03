import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: bottomBarRect
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

    Rectangle {
        id: progressLine
        width: parent.width / 4
        height: 3
        color: "blue"
    }

//    RoundImage {
//        id: disk
//        source: "qrc:/icons/vinyl.jpg"
//        height: parent.height * 1.2
//        width: height
//        anchors.leftMargin: 20
//        anchors.left: parent.left
//        anchors.bottomMargin: 10
//        anchors.bottom: parent.bottom
//    }

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
                anchors.bottomMargin: -bottomBarRect.height * 1.5
            }
        }
    ]

    Timer {
        id: timer
        interval: 25
        repeat: true
        onTriggered: {
            progressLine.width += 1
//            disk.rotation += 3
        }
    }
}
