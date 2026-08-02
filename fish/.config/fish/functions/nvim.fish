function nvim
    if test (count $argv) -gt 0
        if test -w $argv[1]
            command nvim $argv
        else
            sudoedit $argv
        end
    else
        command nvim
    end
end
