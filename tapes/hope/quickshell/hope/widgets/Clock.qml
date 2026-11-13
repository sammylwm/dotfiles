import QtQuick
import QtQuick.Controls
import qs

Item {
    id: clockItem

    property bool showSeconds: false
    property bool use24h: true
    property date currentTime: new Date()
    readonly property var locale: Qt.locale("ru_RU")

    implicitWidth: content.implicitWidth + Theme.spacingMedium * 2
    implicitHeight: Theme.panelHeight - Theme.spacingSmall * 2

    Rectangle {
        anchors.fill: parent
        radius: Theme.radiusSmall
        color: hover.hovered ? Theme.hoverBackground : "transparent"

        Behavior on color {
            ColorAnimation {
                duration: Theme.animationFast
            }
        }
    }

    Row {
        id: content

        anchors.centerIn: parent
        spacing: Theme.spacingLarge

        Text {
            text: {
                const date = clockItem.locale.toString(clockItem.currentTime, "ddd, d MMM");
                return date.charAt(0).toUpperCase() + date.slice(1);
            }
            color: Theme.text
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontNormal
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: Qt.formatDateTime(clockItem.currentTime,
                (clockItem.use24h ? "HH:mm" : "hh:mm")
                + (clockItem.showSeconds ? ":ss" : "")
                + (clockItem.use24h ? "" : " AP"))
            color: Theme.text
            font.family: Theme.fontMono
            font.pixelSize: Theme.fontNormal
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: clockItem.currentTime = new Date()
    }

    HoverHandler {
        id: hover
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: contextMenu.popup()
    }

    Menu {
        id: contextMenu

        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontNormal

        background: Rectangle {
            color: Theme.surface
            radius: Theme.radiusSmall
            border.color: Theme.borderSubtle
        }

        delegate: MenuItem {
            id: menuItem

            implicitHeight: Theme.panelHeight - Theme.spacingSmall

            contentItem: Text {
                text: menuItem.text
                color: menuItem.highlighted ? Theme.primaryLight : Theme.text
                font: menuItem.font
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                color: menuItem.highlighted ? Theme.hoverBackground : "transparent"
                radius: Theme.radiusSmall
            }
        }

        MenuItem {
            text: clockItem.showSeconds ? "Скрыть секунды" : "Показать секунды"
            onTriggered: clockItem.showSeconds = !clockItem.showSeconds
        }

        MenuItem {
            text: clockItem.use24h ? "12-часовой формат" : "24-часовой формат"
            onTriggered: clockItem.use24h = !clockItem.use24h
        }
    }
}
