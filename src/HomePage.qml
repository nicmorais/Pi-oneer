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
            onClicked: bottomBar.hide()
        }
        LargeButton {
            title: "Phone"
            icon: "qrc:/icons/phone.svg"
            onClicked: stackView.push("PhoneConnectPage.qml")

        }
        LargeButton {
            title: "Settings"
            icon: "qrc:/icons/settings.svg"
            onClicked: stackView.push("SettingsPage.qml")
        }
    }


}
