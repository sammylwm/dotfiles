function nvim
    if test (count $argv) -gt 0
        if test ! -e $argv[1]; or test -w $argv[1]
            command nvim $argv
        else
            sudoedit $argv
        end
    else
        command nvim
    end
end
