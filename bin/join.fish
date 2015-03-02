. lib/line.fish

if sudoer $nick $chan
    set join_chan (clean_chan $rest)
    if test -n "$join_chan"
        join $join_chan
        line_add $join_chan var/chans
    end
end
