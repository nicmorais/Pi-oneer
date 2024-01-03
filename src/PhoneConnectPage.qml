import QtQuick 2.15
import pioneer 1.0
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 2.15

Item {
    id: baseItem
    ColumnLayout {
        spacing: 20
        anchors.fill: parent
        RowLayout {
            Layout.margins: 20
            TextField {
                id: ipTextField
                text: "192.168.0.8"
                Layout.fillWidth: true
            }
            TextField {
                id: portTextField
                text: "5900"
                Layout.fillWidth: true
            }
        }
        Button {
            text: "Connect"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                bottomBar.hide()
                vncItem.connect()
            }
        }
    }

    VncItem {
        id: vncItem
        anchors.fill: parent
        ipAddress: ipTextField.text
        port: portTextField.text
    }
}
