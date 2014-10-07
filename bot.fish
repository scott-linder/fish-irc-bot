#!/usr/bin/fish

# Default configuration
set server localhost
set port 6667
set chan test
set nick fish
set user 'fish localhost localhost :fish'
set leader '$'

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
out "NICK $nick"
out "USER $user"
out "JOIN #$chan"
tail -f $OUT | telnet $server $port ^$ERR | tee $IN | while read input;
    log '< '$input
    switch $input
        case 'PING*'
            out $input | sed 's/I/O/'
        case '*PRIVMSG*'
            set components (echo $input | tr ' ' \n)
            if [ (count $components) -ge '4' ]
                set nick (echo $components[1] | sed 's/^:\(.*\)!.*/\1/')
                set chan $components[3]
                set cmd (echo $components[4] | sed -n 's/:'$leader'\([[:alpha:]]\+\)/\1/p')
                if [ (count $components) -ge '5' ]
                    set rest (echo $components[5..-1] | tr \n ' ' | sed 's/[[:space:]]*$//')
                else
                    set rest ''
                end
                if test -n $cmd -a -f mods/$cmd.fish
                    . mods/$cmd.fish
                end
            end
    end
end
