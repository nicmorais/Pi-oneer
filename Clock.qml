import QtQuick 2.15

Item {
    property var locale: Qt.locale()
    property date currentDate: new Date()

    Timer {
        id: timer
        interval: 1000
        onTriggered: currentDate = new Date()
        repeat: true
    }

    Text {
        id: dateTime
        font.bold: true
        text: currentDate.toLocaleTimeString(Qt.locale(), "HH:mm")
        color: "white"
        font.pointSize: 20
    }



    Component.onCompleted: timer.start()
}
