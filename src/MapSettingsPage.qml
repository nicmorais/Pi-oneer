import QtQuick 2.15
import QtCore
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

Item {
    function saveSettings() {
        settings.mapFilesDirectory = mapFilesDirectory.text
    }

    Settings {
        id: settings
        category: "Map"
        property string mapFilesDirectory
    }

    Rectangle {
        id: topBar
        width: parent.width
        implicitHeight: parent.height / 20
        color: "black"
        z: 1

        Image {
            source: "qrc:/icons/navigate_before_white.svg"
            anchors.left: topBar.left
            MouseArea {
                anchors.fill: parent
                onClicked: stackView.pop()
            }
        }

        Button {
            text: qsTr("Save")
            anchors.right: parent.right
            onClicked: {
                saveSettings()
                stackView.pop()
            }
        }
    }

        RowLayout {
            anchors.fill: parent
            Text {
                text: qsTr("Map files directory:")
                color: "white"
                font.pointSize: 12
                Layout.fillWidth: true
                Layout.margins: 10
            }

            TextField {
                id: mapFilesDirectory
                Material.accent: Material.LightBlue
                Layout.fillWidth: true
                implicitWidth: parent.width / 2
                text: settings.value("mapFilesDirectory", "~/pi-oneer/maps")
                Layout.margins: 10
            }
        }
}
