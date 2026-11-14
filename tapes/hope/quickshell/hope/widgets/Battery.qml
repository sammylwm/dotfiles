import QtQuick
import QtQuick.Controls
import Quickshell.Services.UPower
import qs

Item {
    id: root

    property UPowerDevice battery: UPower.displayDevice
    readonly property bool available: battery !== null && battery.ready && battery.isPresent
    readonly property int percentage: available ? Math.max(0, Math.min(100, Math.round(battery.percentage * 100))) : 0
    readonly property bool charging: available && battery.state === UPowerDeviceState.Charging
    readonly property bool fullyCharged: available && battery.state === UPowerDeviceState.FullyCharged
    readonly property real remainingSeconds: available ? (charging ? battery.timeToFull : battery.timeToEmpty) : 0
    readonly property color batteryColor: !available ? Theme.textDisabled : charging || fullyCharged ? Theme.success : percentage <= 10 ? Theme.error : percentage <= 20 ? Theme.warning : Theme.text

    implicitWidth: content.implicitWidth + Theme.spacingMedium
    implicitHeight: Theme.panelHeight - Theme.spacingSmall * 2

    Rectangle {
        anchors.fill: parent
        radius: Theme.radiusSmall
        color: hover.hovered ? Theme.hoverBackground : Theme.widgetBackground

        Behavior on color {
            ColorAnimation {
                duration: Theme.animationFast
            }

        }

    }

    Row {
        id: content

        anchors.centerIn: parent
        spacing: Theme.spacingSmall

        Item {
            width: Theme.iconSize
            height: Theme.iconSize
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                id: outline

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 3
                height: 12
                radius: 3
                color: "transparent"
                border.width: 1.5
                border.color: root.batteryColor

                Rectangle {
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.verticalCenter: parent.verticalCenter
                    width: (parent.width - 6) * root.percentage / 100
                    height: parent.height - 6
                    radius: 1
                    color: root.batteryColor
                    visible: root.available
                }

            }

            Rectangle {
                anchors.left: outline.right
                anchors.leftMargin: 1
                anchors.verticalCenter: parent.verticalCenter
                width: 2
                height: 5
                radius: 1
                color: root.batteryColor
            }

        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.available ? root.percentage + "%" : "-"
            color: root.batteryColor
            font.family: Theme.fontMono
            font.pixelSize: Theme.fontNormal
        }

    }

    HoverHandler {
        id: hover
    }

    ToolTip {
        id: tooltip

        visible: hover.hovered
        delay: Theme.animationSlow
        text: {
            if (!root.available)
                return "Батарея недоступна";

            if (root.fullyCharged)
                return "Батарея полностью заряжена";

            const status = root.charging ? "Заряжается" : "Заряд батареи";
            const label = status + " · " + root.percentage + "%";
            if (root.remainingSeconds <= 0 || (root.battery.state !== UPowerDeviceState.Charging && root.battery.state !== UPowerDeviceState.Discharging))
                return label;

            const minutes = Math.ceil(root.remainingSeconds / 60);
            const time = Math.floor(minutes / 60) + " ч " + minutes % 60 + " мин";
            return label + "\n" + (root.charging ? "До полной зарядки: " : "Осталось: ") + time;
        }

        contentItem: Text {
            text: tooltip.text
            color: Theme.text
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSmall
        }

        background: Rectangle {
            color: Theme.surface
            radius: Theme.radiusSmall
            border.color: Theme.borderSubtle
        }

    }

}
