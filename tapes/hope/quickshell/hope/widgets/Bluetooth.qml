pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth as BT
import qs

Button {
    id: root

    readonly property BT.BluetoothAdapter adapter: BT.Bluetooth.defaultAdapter
    readonly property bool powered: adapter !== null && adapter.enabled

    implicitWidth: Theme.iconSize + Theme.spacingMedium
    implicitHeight: Theme.panelHeight - Theme.spacingSmall * 2
    padding: 0
    onClicked: popup.visible = !popup.visible

    background: Rectangle {
        radius: Theme.radiusSmall
        color: root.hovered || popup.visible ? Theme.hoverBackground : Theme.widgetBackground

        Behavior on color {
            ColorAnimation {
                duration: Theme.animationFast
            }
        }
    }

    contentItem: Item {
        Canvas {
            id: icon

            readonly property color ink: root.powered ? Theme.text : Theme.textDisabled

            anchors.centerIn: parent
            width: Theme.iconSize
            height: Theme.iconSize
            onInkChanged: requestPaint()
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
            onPaint: {
                const ctx = getContext("2d");
                ctx.reset();
                ctx.scale(width / 22, height / 22);
                ctx.strokeStyle = ink;
                ctx.lineWidth = 1.8;
                ctx.lineCap = "round";
                ctx.lineJoin = "round";
                ctx.beginPath();
                ctx.moveTo(6, 6);
                ctx.lineTo(16, 15);
                ctx.lineTo(11, 20);
                ctx.lineTo(11, 2);
                ctx.lineTo(16, 7);
                ctx.lineTo(6, 16);
                ctx.stroke();
            }
        }
    }

    ToolTip {
        id: tooltip

        visible: root.hovered && !popup.visible
        delay: Theme.animationSlow
        text: !root.adapter ? "Bluetooth недоступен" : root.powered ? "Bluetooth включён" : "Bluetooth выключен"

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

    component ActionButton: Button {
        id: control

        property bool accented: false

        implicitHeight: Theme.panelHeight - Theme.spacingSmall
        horizontalPadding: Theme.spacingMedium
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontNormal

        contentItem: Text {
            text: control.text
            font: control.font
            color: !control.enabled ? Theme.textDisabled : control.accented ? Theme.background : Theme.text
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            radius: Theme.radiusSmall
            color: control.accented && control.enabled ? (control.hovered ? Theme.primaryLight : Theme.primary) : (control.hovered && control.enabled ? Theme.hoverBackground : Theme.surfaceVariant)

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animationFast
                }
            }
        }
    }

    PopupWindow {
        id: popup

        anchor.item: root
        anchor.rect.y: root.height + Theme.spacingSmall
        anchor.rect.x: root.width - implicitWidth
        implicitWidth: 400
        implicitHeight: content.implicitHeight + Theme.spacingMedium * 2
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: Theme.surface
            radius: Theme.radiusMedium
            border.color: Theme.borderSubtle
        }

        ColumnLayout {
            id: content

            x: Theme.spacingMedium
            y: Theme.spacingMedium
            width: parent.width - Theme.spacingMedium * 2
            spacing: Theme.spacingMedium

            RowLayout {
                Layout.fillWidth: true

                Text {
                    Layout.fillWidth: true
                    text: "Bluetooth"
                    color: Theme.text
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontMedium
                    font.weight: Font.DemiBold
                }

                ActionButton {
                    text: "Закрыть"
                    onClicked: popup.visible = false
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: Theme.spacingSmall

                ActionButton {
                    Layout.fillWidth: true
                    text: root.powered ? "Выключить" : "Включить"
                    accented: root.powered
                    enabled: root.adapter !== null
                    onClicked: root.adapter.enabled = !root.adapter.enabled
                }

                ActionButton {
                    Layout.fillWidth: true
                    text: root.adapter && root.adapter.discovering ? "Остановить поиск" : "Найти устройства"
                    enabled: root.powered
                    onClicked: root.adapter.discovering = !root.adapter.discovering
                }
            }

            Text {
                Layout.fillWidth: true
                visible: devices.count === 0
                text: !root.adapter ? "Адаптер Bluetooth недоступен" : !root.powered ? "Включите Bluetooth для подключения" : root.adapter.discovering ? "Поиск устройств..." : "Устройства не найдены"
                wrapMode: Text.WordWrap
                color: Theme.textSecondary
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontNormal
                topPadding: Theme.spacingSmall
                bottomPadding: Theme.spacingSmall
            }

            ListView {
                id: devices

                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(contentHeight, 280)
                clip: true
                spacing: Theme.spacingSmall
                model: root.adapter ? root.adapter.devices : null

                delegate: Rectangle {
                    id: deviceRow

                    required property BT.BluetoothDevice modelData
                    readonly property bool busy: modelData.state === BT.BluetoothDeviceState.Connecting || modelData.state === BT.BluetoothDeviceState.Disconnecting

                    width: devices.width
                    height: deviceContent.implicitHeight + Theme.spacingMedium * 2
                    radius: Theme.radiusSmall
                    color: Theme.widgetBackground

                    RowLayout {
                        id: deviceContent

                        anchors.fill: parent
                        anchors.margins: Theme.spacingMedium
                        spacing: Theme.spacingMedium

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: Theme.spacingSmall

                            Text {
                                Layout.fillWidth: true
                                text: deviceRow.modelData.name || deviceRow.modelData.address
                                elide: Text.ElideRight
                                color: Theme.text
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontNormal
                            }

                            Text {
                                Layout.fillWidth: true
                                text: deviceRow.modelData.state === BT.BluetoothDeviceState.Connecting ? "Подключение..." : deviceRow.modelData.state === BT.BluetoothDeviceState.Disconnecting ? "Отключение..." : deviceRow.modelData.connected ? "Подключено" : "Не подключено"
                                elide: Text.ElideRight
                                color: deviceRow.modelData.connected ? Theme.success : Theme.textSecondary
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSmall
                            }
                        }

                        ActionButton {
                            text: deviceRow.modelData.connected ? "Отключить" : "Подключить"
                            enabled: root.powered && !deviceRow.busy
                            onClicked: deviceRow.modelData.connected = !deviceRow.modelData.connected
                        }
                    }
                }
            }
        }
    }
}
