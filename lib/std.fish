function log -d 'Write to log file'
    echo (date '+[%y:%m:%d %T]')' '$argv[1] | tee -a $LOG
end

function out -d "Write to IRC server"
    set -l output $argv[1]
    log '>'$output
    echo $output >>$OUT
end

function msg -d "Send a PRIVMSG"
    set -l chan $argv[1]
    set -l rest $argv[2..-1]
    out "PRIVMSG $chan :$rest"
end

function me -d "Send a PRIVMSG ACTION"
    set -l chan $argv[1]
    set -l rest $argv[2..-1]
    msg $chan \001'ACTION '$rest
end
