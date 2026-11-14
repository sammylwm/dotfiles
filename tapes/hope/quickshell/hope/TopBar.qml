import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs
import qs.widgets

PanelWindow {
    id: bar

    signal launcherRequested()

    implicitHeight: 42
    color: "#191715"

    anchors {
        top: true
        left: true
        right: true
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 16

        Button {
            id: launcherButton
            implicitWidth: 36
            implicitHeight: 32
            focusPolicy: Qt.NoFocus
            onClicked: bar.launcherRequested()
            contentItem: Text {
                text: "☦"
                color: Theme.primary
                font.pixelSize: 25
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle {
                radius: Theme.radiusSmall
                color: launcherButton.hovered ? Theme.hoverBackground : "transparent"
            }
            ToolTip.visible: hovered
            ToolTip.delay: Theme.animationSlow
            ToolTip.text: "Приложения"
        }

        Workspaces {
        }

        Item {
            Layout.fillWidth: true
        }

    }

    Clock {
        anchors.centerIn: parent
    }

    RowLayout {
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16
        anchors.right: parent.right

        Bluetooth {
        }

        Battery {
        }

        Wifi {
        }

    }

}
