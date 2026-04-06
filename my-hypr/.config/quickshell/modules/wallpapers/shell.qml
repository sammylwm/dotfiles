import Quickshell
import QtQuick 6.10

Item {
    WallpaperPicker {
        id: picker
    }

    IpcHandler {
        target: "wallpaper-picker"
        function handle(cmd) {
            if (cmd === "toggle") picker.visible = !picker.visible
        }
    }
}