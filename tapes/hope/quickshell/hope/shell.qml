import QtQuick
import Quickshell
import qs.widgets

ShellRoot {
    Launcher {
        id: launcher
    }

    TopBar {
        onLauncherRequested: launcher.toggle()
    }

}
