#!/usr/bin/fish

# Default configuration
set SERVER localhost
set PORT 6667
set NICK fish
set IRCUSER 'fish localhost localhost :fish'
set LEADER '$'

# User configuration
. etc/config.fish

# Constants
set IN 'var/bot.in'
set OUT 'var/bot.out'
set LOG 'var/log/bot'

# Standard functions
. lib/std.fish

# Initialization
echo "" >$IN
echo "" >$OUT
mkdir -p var/log

# Connection
tail -f $OUT | nc -C $SERVER $PORT >> $IN &

# Session
log ">>>>> New Session <<<<<"
out "NICK $NICK"
out "USER $IRCUSER"
for chan in (cat var/chans)
    set join_chan (clean_chan $chan)
    if test -n "$join_chan"
        join $join_chan
    end
end
tail -f $IN | while read input;
    log '< '$input
    switch $input
        case 'PING*'
            out (echo $input | sed 's/I/O/')
        case '*PRIVMSG*'
            set components (echo $input | tr -d \r\n | tr ' ' \n)
            if [ (count $components) -ge '4' ]
                set nick (echo $components[1] | sed 's/^:\(.*\)!.*/\1/')
                set chan $components[3]
                # if a user is PM'ing us, rather than a chan
                if test $chan = $NICK
                    set chan $nick
                else
                    chat_log $nick $chan (echo $components[4..-1] | sed -n 's/^:\?\(.*\)$/\1/p')
                end
                set cmd (echo $components[4] | sed -n 's/:\?'$LEADER'\([[:alnum:]]\+\)/\1/p')
                if [ (count $components) -ge '5' ]
                    set rest (echo $components[5..-1])
                else
                    set rest ''
                end
                if not grep -Fxq $nick etc/ignore
                    if test -n "$cmd"
                        # `$foo` is sugar for `$cat foo` if $foo is not a command
                        if not test -f bin/$cmd.fish
                            set rest $cmd
                            set cmd rand
                        end
                        log '. 'bin/$cmd.fish
                        . bin/$cmd.fish
                    end
                end
            end
    end
end
