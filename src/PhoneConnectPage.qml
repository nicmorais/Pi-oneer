import QtQuick 2.15
import pioneer 1.0
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 2.15

Item {
    id: baseItem
    Rectangle {
        id: topBar
        anchors.top: parent.top
        width: parent.width
        implicitHeight: baseItem.height / 20
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
    }

    Popup {
        id: errorPopup
        anchors.centerIn: baseItem
        width: vncItem.width * 0.7
        height: vncItem.height * 0.7
        z: 2
        background: Rectangle {
            color: "white"
            opacity: 0.9
            radius: Math.min(height, width) / 10
        }
        ColumnLayout {
            anchors.centerIn: parent
            Text {
                Layout.fillWidth: true
                color: "black"
                text: "Error: " + vncItem.lastError
                font.pointSize: 15
            }
            RowLayout {
                Button {
                    Layout.fillWidth: true
                    text: "Exit"
                    onClicked: {
                        errorPopup.close()
                        stackView.replace("HomePage.qml")
                    }
                }
                Button {
                    highlighted: true
                    Layout.fillWidth: true
                    text: "Retry"
                    onClicked: vncItem.connect()
                }
            }
        }

    }

    ColumnLayout {
        spacing: 20
        anchors.fill: parent

        RowLayout {
            Layout.margins: 20
            Text {
                text: "Phone IP:"
                color: "white"
            }
            TextField {
                id: ipTextField
                text: "192.168.0.8"
                Layout.fillWidth: true
            }
            Text {
                text: "VNC Port:"
                color: "white"
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
                vncItem.connect()
                mouseArea.enabled = true
            }
        }
    }

    VncItem {
        id: vncItem
        anchors.fill: parent
        ipAddress: ipTextField.text
        port: portTextField.text
        onConnected: bottomBar.hide()
        onLastErrorChanged: errorPopup.open()
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            enabled: false
            onPressed: (mouse) => vncItem.sendClickEvent(mouse.x, mouse.y);
            onReleased: (mouse) => vncItem.sendReleaseEvent(mouse.x, mouse.y);
        }
    }

    Component.onDestruction: {
        bottomBar.show()
        vncItem.stop()
    }
}
