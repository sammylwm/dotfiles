import QtQuick
import QtQuick.Controls
import qs
import Quickshell.Networking

Item {
    id: root

    readonly property var primaryDevice: {
        const devices = Networking.devices.values;
        for (const device of devices) {
            if (device.connected)
                return device;

        }
        return null;
    }
    readonly property var connection: {
        if (!primaryDevice)
            return null;

        for (const network of primaryDevice.networks.values) {
            if (network.connected)
                return network;

        }
        return null;
    }
    readonly property string ssid: connection ? connection.name : ""
    readonly property int signalStrength: connection && primaryDevice.type === DeviceType.Wifi ? Math.round(connection.signalStrength * 100) : -1
    readonly property bool connected: primaryDevice !== null

    implicitWidth: Theme.iconSize + Theme.spacingMedium
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

    Canvas {
        id: icon

        readonly property color ink: root.connected ? Theme.text : Theme.textDisabled
        readonly property color mutedInk: Theme.borderSubtle
        readonly property int strength: root.signalStrength
        readonly property bool wired: root.primaryDevice !== null && root.primaryDevice.type === DeviceType.Wired
        readonly property bool connected: root.connected

        anchors.centerIn: parent
        width: Theme.iconSize
        height: Theme.iconSize

        onInkChanged: requestPaint()
        onMutedInkChanged: requestPaint()
        onStrengthChanged: requestPaint()
        onWiredChanged: requestPaint()
        onConnectedChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()

        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.scale(width / 22, height / 22);
            ctx.lineWidth = 1.8;
            ctx.lineCap = "round";
            ctx.lineJoin = "round";

            if (wired) {
                ctx.strokeStyle = ink;
                ctx.strokeRect(5, 3, 12, 9);
                ctx.beginPath();
                ctx.moveTo(11, 12);
                ctx.lineTo(11, 18);
                ctx.moveTo(5, 18);
                ctx.lineTo(17, 18);
                ctx.stroke();
                return;
            }

            for (let i = 0; i < 3; i++) {
                ctx.strokeStyle = connected && strength >= i * 30 ? ink : mutedInk;
                ctx.beginPath();
                ctx.arc(11, 17, 4 + i * 4, -Math.PI * 0.75, -Math.PI * 0.25);
                ctx.stroke();
            }

            ctx.fillStyle = ink;
            ctx.beginPath();
            ctx.arc(11, 17, 1.3, 0, Math.PI * 2);
            ctx.fill();

            if (!connected) {
                ctx.strokeStyle = ink;
                ctx.beginPath();
                ctx.moveTo(4, 4);
                ctx.lineTo(18, 18);
                ctx.stroke();
            }
        }
    }

    HoverHandler {
        id: hover
    }

    ToolTip {
        id: tooltip

        visible: hover.hovered
        delay: Theme.animationSlow
        text: root.connected
            ? (root.ssid || "Проводное подключение") + (root.signalStrength >= 0 ? " · " + root.signalStrength + "%" : "")
            : "Нет подключения"

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
