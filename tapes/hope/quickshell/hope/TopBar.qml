import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.widgets

PanelWindow {
    id: bar

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

        Text {
            text: "☦"
            color: "#D6A65C"
            font.pixelSize: 25
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

        Wifi {
        }

    }

}
