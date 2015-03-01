function log -d 'Write to log file'
    echo (date '+[%y:%m:%d %T]')' '$argv[1] | tee -a $LOG
end

function out -d "Write to IRC server"
    set -l output $argv[1]
    log '> '$output
    echo -n $output | head -c 510 | cat - (echo \r\n | psub) >>$OUT
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
    set -l chan $argv[2]
    # channels are only moderated if they have a file in sudoers.d
    if test -f etc/sudoers.d/$chan
        # check global moderator list
        grep -Fxq $user etc/sudoers
        # then per chan list
        or grep -Fxq $user etc/sudoers.d/$chan
        or begin
            msg $chan $user": Aquaman says he doesn't like you."
            false
        end
    else
        true
    end
end
