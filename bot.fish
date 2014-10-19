#!/usr/bin/fish

# Default configuration
set SERVER localhost
set PORT 6667
set CHANS test
set NICK fish
set IRCUSER 'fish localhost localhost :fish'
set LEADER '$'
set IGNORE
set SUDOERS

# User configuration
. bot.cfg

# Constants
set IN 'bot.input'
set OUT 'bot.output'
set ERR 'bot.error'
set LOG 'bot.log'

# Standard functions
. lib/std.fish

# Initialization
echo "" >$OUT
mkdir -p data/

# Session
log ">>>>> New Session <<<<<"
out "NICK $NICK"
out "USER $IRCUSER"
for chan in $CHANS
    join "#$chan"
end
tail -f $OUT | telnet $SERVER $PORT ^$ERR | tee $IN | while read input;
    log '< '$input
    switch $input
        case 'PING*'
            out $input | sed 's/I/O/'
        case '*PRIVMSG*'
            set components (echo $input | tr ' ' \n)
            if [ (count $components) -ge '4' ]
                set nick (echo $components[1] | sed 's/^:\(.*\)!.*/\1/')
                set chan $components[3]
                # if a user is PM'ing us, rather than a chan
                if test $chan = $NICK
                    set chan $nick
                end
                set cmd (echo $components[4] | sed -n 's/:'$LEADER'\([[:alnum:]]\+\)/\1/p')
                if [ (count $components) -ge '5' ]
                    set rest (echo $components[5..-1] | tr \n ' ' | sed 's/[[:space:]]*$//')
                else
                    set rest ''
                end
                if test -n $cmd -a -f cmd/$cmd.fish
                    if not contains $nick $IGNORE
                        log '. 'cmd/$cmd.fish
                        . cmd/$cmd.fish
                    end
                end
            end
    end
end
