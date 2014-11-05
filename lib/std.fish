function log -d 'Write to log file'
    echo (date '+[%y:%m:%d %T]')' '$argv[1] | tee -a $LOG
end

function out -d "Write to IRC server"
    set -l output $argv[1]
    log '> '$output
    echo $output | head -c 512 >>$OUT
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

function clean_chan -d "Cleanup a channel name"
    echo $argv[1] | tr -d ' \007,'
end

function join -d "Join a channel"
    set -l chan (clean_chan $argv[1])
    if test -n $chan
        out "JOIN $chan"
    end
end

function part -d "Part a channel"
    set -l chan (clean_chan $argv[1])
    if test -n $chan
        out "PART $chan :blub blub"
    end
end

function sudoer -d "Check if user is admin"
    set -l user $argv[1]
    grep -Fxq $user etc/sudoers
    or begin
        msg $chan $user': Aquaman told me I can\'t let you do that. This incident will be reported.'
        false
    end
end
