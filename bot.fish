#!/usr/bin/fish

# Default configuration
set server localhost
set port 6667
set chan test
set nick fish
set user "fish localhost localhost :fish"

# User configuration
. bot.cfg

# Constants
set IN "bot.input"
set OUT "bot.output"
set ERR "bot.error"
set LOG "bot.log"

# Functions
function log -d "Write to log file"
    echo (date '+[%y:%m:%d %T]')" $argv[1]" | tee -a $LOG
end

function out -d "Write to IRC server"
    set -l output "$argv[1]"
    log "$output"
    echo "$output" >>$OUT
end

# Initialization
echo "" >$OUT

# Session
log ">>>>> New Session <<<<<"
out "NICK $nick"
out "USER $user"
out "JOIN #$chan"
tail -f $OUT | telnet $server $port ^$ERR | tee $IN | while read input;
    log $input
    switch $input
        case 'PING*'
            out "$input" | sed "s/I/O/"
        case '*You have not*'
            out "JOIN #$chan"
        case '*PRIVMSG*'
            # TODO: Parse PRIVMSG and implement modular commands
            out "PRIVMSG #$chan :I is fish :^D"
    end
end
