import QtQuick
import QtQuick.Controls

Text {
    id: clockItem

    property bool showSeconds: true
    property bool use24h: true

    property date currentTime: new Date()

    text: Qt.formatDateTime(clockItem.currentTime,
        (clockItem.use24h ? "HH:mm" : "hh:mm")
        + (clockItem.showSeconds ? ":ss" : "")
        + (clockItem.use24h ? "" : " AP"))
    font.pixelSize: 14
    color: "#cdd6f4"

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: clockItem.currentTime = new Date()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: contextMenu.open()

        Menu {
            id: contextMenu

            MenuItem {
                text: clockItem.showSeconds ? "Hide seconds" : "Show seconds"
                onTriggered: clockItem.showSeconds = !clockItem.showSeconds
            }

            MenuItem {
                text: clockItem.use24h ? "Use 12h format" : "Use 24h format"
                onTriggered: clockItem.use24h = !clockItem.use24h
            }

        }

    }

}
