function gcp
    if test (count $argv) -eq 0
        set msg (date '+%Y-%m-%d')
    else
        set msg (string join ' ' $argv)
    end
    git add .
    git commit -m "$msg"
    git push
end
