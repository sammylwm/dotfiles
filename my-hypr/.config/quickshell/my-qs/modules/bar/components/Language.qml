import QtQuick 6.10
import QtQuick.Layouts 6.10
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import "../../../services" as QsServices

// Keyboard layout indicator - показывает текущую раскладку, обновляется мгновенно
Item {
    id: root

    readonly property var pywal: QsServices.Pywal
    readonly property bool isHovered: mouseArea.containsMouse

    property string layout: "??"

    // Короткое отображение: "English (US)" → "EN", "Russian" → "RU"
    readonly property string shortLayout: {
        var raw = layout.trim().toLowerCase()

        if (!raw || raw === "??") return "??"

        // если hyprland даёт "english" / "english(us)"
        if (raw.includes("english")) return "EN"
        if (raw.includes("russian") || raw.includes("ru")) return "RU"

        // fallback: берём первые 2 буквы только если это чистый код
        if (raw.length <= 3) return raw.substring(0, 2).toUpperCase()

        return raw.substring(0, 2).toUpperCase()
    }

    implicitWidth: layoutRow.implicitWidth
    implicitHeight: 20

    // ── Начальное значение через hyprctl ─────────────────────────────────
    Process {
        command: ["bash", "-c",
            "hyprctl devices -j | python3 -c \""        +
            "import sys,json; d=json.load(sys.stdin); " +
            "kb=d.get('keyboards',[]); "                +
            "print(kb[0].get('active_keymap','') if kb else '')\""]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                var v = text.trim()
                if (v) root.layout = v
            }
        }
    }

    // ── Hyprland событие activelayout → мгновенное обновление ────────────
    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                var idx = event.data.indexOf(",")
                if (idx !== -1)
                    root.layout = event.data.substring(idx + 1).trim()
            }
        }
    }

    // ── UI ────────────────────────────────────────────────────────────────
    RowLayout {
        id: layoutRow
        anchors.centerIn: parent
        spacing: 5

        // Иконка клавиатуры
        Text {
            id: kbIcon
            Layout.alignment: Qt.AlignVCenter

            text: "󰌌"
            font.family: "Material Design Icons"
            font.pixelSize: 14

            color: isHovered
                ? pywal.primary
                : Qt.rgba(pywal.foreground.r, pywal.foreground.g, pywal.foreground.b, 0.8)

            Behavior on color { ColorAnimation { duration: 150 } }

            scale: isHovered ? 1.05 : 1.0
            Behavior on scale { NumberAnimation { duration: 100 } }
        }

        // Короткое имя раскладки
        Text {
            id: layoutText

            text: root.shortLayout

            opacity: 1

            font.family: "Inter"
            font.pixelSize: 10
            font.weight: Font.Medium

            Layout.preferredWidth: 24
            horizontalAlignment: Text.AlignHCenter
            color: isHovered

                ? pywal.foreground

                : Qt.rgba(pywal.foreground.r, pywal.foreground.g, pywal.foreground.b, 0.75)
                
            Behavior on opacity {
                NumberAnimation { duration: 80 }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        anchors.margins: -4
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        // Клик — переключить на следующую раскладку
        onClicked: {
           
        }
    }
}
