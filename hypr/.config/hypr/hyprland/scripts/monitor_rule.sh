#!/bin/sh

INTERNAL="eDP-1"
EXTERNAL="HDMI-A-1"

STATE=$(hyprctl monitors -j)

# Проверяем, есть ли HDMI как отдельный монитор
HDMI_PRESENT=$(echo "$STATE" | jq -r ".[] | select(.name==\"$EXTERNAL\") | .name")

if [ -z "$HDMI_PRESENT" ]; then
    # HDMI отсутствует → сейчас MIRROR → выключаем
    hyprctl keyword monitor "$EXTERNAL,highres,auto,1"
    echo "ok"
    echo "Mode: DEFAULT"
else
    # HDMI присутствует → обычный режим → включаем mirror
    hyprctl keyword monitor "$EXTERNAL,highres,auto,auto,mirror,$INTERNAL"
    echo "ok"
    echo "Mode: MIRROR"
fi
