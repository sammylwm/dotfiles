source ~/.config/fish/alias.fish
zoxide init --cmd cd fish | source
set fish_greeting
starship init fish | source
export EDITOR=nvim

# Flutter / Android development
set -gx ANDROID_HOME /home/sammy/Android/Sdk
set -gx ANDROID_SDK_ROOT /home/sammy/Android/Sdk
set -gx CHROME_EXECUTABLE /usr/bin/chromium
fish_add_path /home/sammy/Android/Sdk/platform-tools /home/sammy/Android/Sdk/cmdline-tools/latest/bin

# Created by `pipx` on 2026-07-22 19:06:59
set PATH $PATH /home/sammy/.local/bin
