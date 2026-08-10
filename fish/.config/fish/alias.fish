alias cd="z"
alias c="clear"
alias ls="eza"
alias aliascf="nano ~/.config/fish/alias.fish"
alias hs="fzf"
alias pc="podman compose"
alias pcdev="podman compose -f compose.dev.yaml"
alias almrev="alembic revision --autogenerate -m"
alias almup="alembic upgrade head"
alias flutter_build="flutter pub run build_runner build --delete-conflicting-outputs"
alias dcdev="docker compose -f docker-compose.dev.yml"
alias sshp="ssh -p 1009 sammy@lednevs.ru"
alias logout="hyprshutdown"
alias nano="nvim"
alias nv='nvim $argv.lua'
alias yay="paru"

# Birthday Calendar: upload AAB and only "What's new" to Closed testing (Alpha)
function birthday_publish
    command fastlane supply \
        --aab /home/sammy/it/birthday_calendar/build/app/outputs/bundle/release/app-release.aab \
        --json_key /home/sammy/Documents/birthday-calendar-a0913-589cfd7cf636.json \
        --package_name com.sammy.birthday_calendar \
        --track alpha \
        --release_status completed \
        --metadata_path /home/sammy/it/birthday_calendar/metadata \
        --skip_upload_metadata true \
        --skip_upload_images true \
        --skip_upload_screenshots true
end
