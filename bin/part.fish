. lib/line.fish

if sudoer $nick $chan
    set part_chan (clean_chan $rest)
    if test -n "$part_chan"
        part $part_chan
        line_del $part_chan var/chans
    end
end
