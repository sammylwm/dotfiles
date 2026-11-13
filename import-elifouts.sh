set -euo pipefail

expected="$HOME/dotfiles/tapes"
actual="$(readlink -f "$HOME/.tapes")"
if [[ "$actual" != "$expected" ]]; then
    printf 'Unexpected tapes directory: %s\n' "$actual" >&2
    exit 1
fi
if [[ -e "$expected/elifouts" || -L "$expected/elifouts" ]]; then
    printf 'Already exists: %s\n' "$expected/elifouts" >&2
    exit 1
fi

tapes install https://github.com/elifouts/Dotfiles --name elifouts --dir .config --no-hooks
cat > "$expected/elifouts/tape.toml" <<'EOF'
[tape]
name = "elifouts"
desc = "Hyprland dotfiles from https://github.com/elifouts/Dotfiles"
EOF
printf 'Saved configs to %s\n' "$expected/elifouts"
