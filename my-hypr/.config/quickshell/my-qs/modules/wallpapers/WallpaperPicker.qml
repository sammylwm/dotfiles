import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

FloatingWindow { 
    id: root
    title: "wallpaper-picker"
    visible: false
    implicitWidth: 900
    implicitHeight: 600
    onVisibleChanged: {
        console.log("WallpaperPicker visible changed:", visible)
        if (visible) requestActivate()
    }


    property string wallpaperDir: "/home/sammy/dotfiles/Wallpapers"
    property var wallpapers: []

    Process {
        id: listFiles
        command: ["bash", "-c", `find "${root.wallpaperDir}" -maxdepth 1 -type f \\( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \\) | sort`]
        stdout: SplitParser {
            onRead: data => {
                if (data.trim().length > 0)
                    root.wallpapers = [...root.wallpapers, data.trim()]
            }
        }
    }

    Process {
        id: applyWallpaper
        property string target: ""
        command: ["awww", "img", target, "--transition-type", "wipe", "--transition-duration", "1"]
    }

    Component.onCompleted: listFiles.running = true

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        radius: 12

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            Text {
                text: "Wallpapers"
                color: "#cdd6f4"
                font.pixelSize: 18
                font.bold: true
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                GridView {
                    id: grid
                    anchors.fill: parent
                    model: root.wallpapers
                    cellWidth: 200
                    cellHeight: 130

                    delegate: Item {
                        width: 196
                        height: 126

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 4
                            radius: 8
                            color: "#313244"
                            clip: true

                            Image {
                                anchors.fill: parent
                                source: "file://" + modelData
                                fillMode: Image.PreserveAspectCrop
                                asynchronous: true
                                smooth: true
                            }

                            Rectangle {
                                anchors.fill: parent
                                radius: 8
                                color: hoverArea.containsMouse ? "#44cba6f0" : "transparent"
                                Behavior on color {
                                    ColorAnimation { duration: 150 }
                                }
                            }

                            MouseArea {
                                id: hoverArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    applyWallpaper.target = modelData
                                    applyWallpaper.running = true
                                    root.visible = false
                                }
                            }
                        }
                    }

                }
            }

            Button {
                text: "Close"
                onClicked: root.visible = false
            }
        }
    }
}