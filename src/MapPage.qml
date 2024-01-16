import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15
import QtCore

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

        Image {
            source: "qrc:/icons/search.svg"
            anchors.right: topBar.right
            MouseArea {
                anchors.fill: parent
                onClicked: stackView.push()
            }
        }
    }

    Settings {
        id: settings
    }

    Plugin {
        id: mapPlugin
        name: "osm"
        PluginParameter {
            name: "osm.mapping.offline.directory"
            value: settings.value("mapFilesDirectory", "~/pi-oneer/maps")
        }
        PluginParameter {
            name: "osm.mapping.providersrepository.disabled"
            value: true
        }
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
//        center: QtPositioning.coordinate(42.544829, 1.515009)
        zoomLevel: 12

        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        PinchHandler {
            onScaleChanged: (delta) => {
                map.pinchAdjustingZoom = true
                map.zoomLevel += Math.log2(delta)
                map.alignCoordinateToPoint(pinch.startCentroid, pinch.centroid.position)
                map.pinchAdjustingZoom = false
            }
        }
    }

    Component.onCompleted: bottomBar.hide()
    Component.onDestruction: bottomBar.show()

}
