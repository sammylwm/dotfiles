import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            id: workspace

            required property var modelData
            readonly property bool isSpecial: modelData.name.startsWith("special:")
            readonly property bool active: modelData.active

            visible: !isSpecial
            width: isSpecial ? 0 : (active ? 34 : 28)
            height: 28
            radius: 9
            color: active ? "#D6A65C" : "#3A3029"

            Text {
                anchors.centerIn: parent
                text: workspace.modelData.name
                color: workspace.active ? "#191715" : "#F5E8D6"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: workspace.modelData.activate()
            }

            Behavior on width {
                NumberAnimation {
                    duration: 180
                }

            }

        }

    }

}
