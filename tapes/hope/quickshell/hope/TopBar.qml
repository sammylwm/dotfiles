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
        // Widgets.Clock {
        // }

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

}
