. lib/opts.fish
. lib/sed.fish

set opts (opts_getopts c: $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)

set nick_find (sed_escape_regexp $rest)
set chan_find '[^ ]\+'

set i 1
while test $i -le (count $flags)
    switch $flags[$i]
        case '-c'
            set i (math $i+1)
            set chan_find (sed_escape_regexp $flags[$i])
    end
    set i (math $i+1)
end

set find (sed -n "s/^$nick_find \($chan_find\) \([^ ]\+\) \([^ ]\+\) \(.*\)/$nick was last seen in \1 on \2 at \3 saying '\4'/p" var/chat.log | tail -1)

if test -n "$find"
    msg $chan $find
else
    msg $chan $nick": haven't seen $rest"
end
