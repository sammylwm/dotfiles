#!/bin/bash

set -e
packages="hiddify"

is_installed() {
    if pacman -Q "$1" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

for pkg in $packages; do
    if ! is_installed "$pkg"; then
        echo "Пакет $pkg не установлен. Устанавливаю через paru..."
        paru -S --needed --noconfirm "$pkg"
    else
        echo "Пакет $pkg уже установлен."
    fi
done

sudo tee /etc/polkit-1/rules.d/49-nopass.rules > /dev/null <<'EOF'
polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
EOF

sudo systemctl restart polkit

sudo tee /usr/share/applications/hiddify.desktop > /dev/null <<'EOF'
[Desktop Entry]
Type=Application
Name=Hiddify
Icon=hiddify
Exec=vpn_start
Categories=Network;
StartupNotify=true
Terminal=false
EOF

sudo tee /usr/bin/vpn_start > /dev/null <<'EOF'
pkexec env DISPLAY=$DISPLAY WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_SESSION_TYPE=$XDG_SESSION_TYPE XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR hiddify
EOF


echo "✅ Установка завершена!"
