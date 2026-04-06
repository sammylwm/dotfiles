import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    // Прикрепляем к краю экрана
    anchors {
        top: true
        left: true
        right: true
    }

    height: 36
    color: "transparent"

    // Содержимое бара
    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        radius: 8

        Row {
            anchors.fill: parent
            Text {
                text: "Hello Bar"
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}