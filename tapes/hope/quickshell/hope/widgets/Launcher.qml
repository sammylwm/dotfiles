import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs

Scope {
    id: root

    property bool opened: false
    readonly property var results: {
        const terms = search.text.trim().toLocaleLowerCase().split(/\s+/).filter(Boolean);
        return DesktopEntries.applications.values.filter(entry => {
            const haystack = [entry.name, entry.genericName, entry.comment, entry.id, ...(entry.keywords || [])].join(" ").toLocaleLowerCase();
            return terms.every(term => haystack.includes(term));
        }).sort((a, b) => {
            const query = search.text.trim().toLocaleLowerCase();
            const aPrefix = a.name.toLocaleLowerCase().startsWith(query);
            const bPrefix = b.name.toLocaleLowerCase().startsWith(query);
            return aPrefix !== bPrefix ? (aPrefix ? -1 : 1) : a.name.localeCompare(b.name);
        });
    }

    function toggle(): void {
        opened = !opened;
    }

    function launchCurrent(): void {
        const entry = results[list.currentIndex];
        if (entry) {
            entry.execute();
            opened = false;
        }
    }

    function moveSelection(step: int): void {
        if (list.count > 0) {
            list.currentIndex = (Math.max(0, list.currentIndex) + step + list.count) % list.count;
            list.positionViewAtIndex(list.currentIndex, ListView.Contain);
        }
    }

    onResultsChanged: list.currentIndex = results.length > 0 ? 0 : -1
    onOpenedChanged: {
        if (opened) {
            search.clear();
            list.currentIndex = results.length > 0 ? 0 : -1;
            Qt.callLater(() => search.forceActiveFocus());
        }
    }

    IpcHandler {
        target: "launcher"
        function toggle(): void { root.toggle(); }
        function open(): void { root.opened = true; }
        function close(): void { root.opened = false; }
    }

    PanelWindow {
        id: window

        visible: root.opened
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        anchors { top: true; bottom: true; left: true; right: true }
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "hope-launcher"
        WlrLayershell.keyboardFocus: root.opened ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

        Rectangle {
            anchors.fill: parent
            color: "#990F0D0B"
            MouseArea {
                anchors.fill: parent
                onClicked: root.opened = false
            }
        }

        Rectangle {
            id: card

            anchors.centerIn: parent
            width: Math.min(600, parent.width - Theme.spacingLarge * 2)
            height: Math.min(620, parent.height - Theme.spacingLarge * 2)
            radius: Theme.radiusLarge
            color: Theme.surface
            border.color: Theme.border

            MouseArea { anchors.fill: parent }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Theme.spacingLarge
                spacing: Theme.spacingMedium

                RowLayout {
                    Layout.fillWidth: true
                    spacing: Theme.spacingMedium

                    Text {
                        text: "☦"
                        color: Theme.primary
                        font.pixelSize: Theme.fontTitle
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 2
                        Text {
                            text: "Приложения"
                            color: Theme.text
                            font.family: Theme.fontDisplay
                            font.pixelSize: Theme.fontTitle
                        }
                        Text {
                            text: "Найдите и откройте нужное"
                            color: Theme.textSecondary
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontNormal
                        }
                    }

                    Button {
                        id: closeButton
                        text: "Esc"
                        focusPolicy: Qt.NoFocus
                        onClicked: root.opened = false
                        contentItem: Text {
                            text: closeButton.text
                            color: Theme.textSecondary
                            font.family: Theme.fontMono
                            font.pixelSize: Theme.fontSmall
                        }
                        background: Rectangle {
                            radius: Theme.radiusSmall
                            color: closeButton.hovered ? Theme.hoverBackground : Theme.surfaceVariant
                        }
                    }
                }

                TextField {
                    id: search

                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    placeholderText: "Поиск приложений..."
                    color: Theme.text
                    placeholderTextColor: Theme.textDisabled
                    selectionColor: Theme.primary
                    selectedTextColor: Theme.background
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontMedium
                    padding: Theme.spacingMedium
                    focus: true
                    background: Rectangle {
                        color: Theme.background
                        radius: Theme.radiusMedium
                        border.color: search.activeFocus ? Theme.primary : Theme.borderSubtle
                        Behavior on border.color { ColorAnimation { duration: Theme.animationFast } }
                    }
                    Keys.onDownPressed: root.moveSelection(1)
                    Keys.onUpPressed: root.moveSelection(-1)
                    Keys.onEscapePressed: root.opened = false
                    onAccepted: root.launchCurrent()
                }

                ListView {
                    id: list

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: Theme.spacingSmall
                    boundsBehavior: Flickable.StopAtBounds
                    model: root.results
                    keyNavigationEnabled: false
                    ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

                    delegate: ItemDelegate {
                        id: entryDelegate

                        required property var modelData
                        required property int index
                        width: ListView.view.width
                        height: 64
                        padding: Theme.spacingMedium
                        highlighted: ListView.isCurrentItem
                        focusPolicy: Qt.NoFocus

                        contentItem: RowLayout {
                            spacing: Theme.spacingMedium

                            Image {
                                Layout.preferredWidth: 36
                                Layout.preferredHeight: 36
                                source: Quickshell.iconPath(entryDelegate.modelData.icon, "application-x-executable")
                                sourceSize.width: 36
                                sourceSize.height: 36
                                fillMode: Image.PreserveAspectFit
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 3
                                Text {
                                    Layout.fillWidth: true
                                    text: entryDelegate.modelData.name
                                    color: entryDelegate.highlighted ? Theme.background : Theme.text
                                    font.family: Theme.fontFamily
                                    font.pixelSize: Theme.fontMedium
                                    font.weight: Font.Medium
                                    elide: Text.ElideRight
                                }
                                Text {
                                    Layout.fillWidth: true
                                    text: entryDelegate.modelData.genericName || entryDelegate.modelData.comment || entryDelegate.modelData.id
                                    color: entryDelegate.highlighted ? Theme.surfaceVariant : Theme.textSecondary
                                    font.family: Theme.fontFamily
                                    font.pixelSize: Theme.fontSmall
                                    elide: Text.ElideRight
                                }
                            }

                            Text {
                                visible: entryDelegate.highlighted
                                text: "↵"
                                color: Theme.background
                                font.pixelSize: Theme.fontLarge
                            }
                        }

                        background: Rectangle {
                            radius: Theme.radiusMedium
                            color: entryDelegate.highlighted ? Theme.activeBackground : entryDelegate.hovered ? Theme.hoverBackground : Theme.widgetBackground
                            Behavior on color { ColorAnimation { duration: Theme.animationFast } }
                        }

                        onClicked: {
                            list.currentIndex = index;
                            root.launchCurrent();
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        width: parent.width - Theme.spacingLarge * 2
                        visible: list.count === 0
                        text: "Ничего не найдено\nПопробуйте другое название"
                        color: Theme.textSecondary
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontMedium
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Text {
                        Layout.fillWidth: true
                        text: "↑ ↓  Выбор     Enter  Открыть"
                        color: Theme.textDisabled
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSmall
                    }
                    Text {
                        text: list.count
                        color: Theme.primary
                        font.family: Theme.fontMono
                        font.pixelSize: Theme.fontSmall
                    }
                }
            }
        }
    }
}
