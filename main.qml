import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Window {
    width: 720
    height: 480
    visible: true
    color: "black"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "HomePage.qml"
    }
}
