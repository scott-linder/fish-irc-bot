. lib/color.fish
. lib/opts.fish

set opts (opts_getopts rc: $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)
set rest (echo $rest)

set should_rainbow
set o_count (math (random)%64+4)

set i 1
while test $i -le (count $flags)
    switch $flags[$i]
        case '-r'
            set should_rainbow 1
        case '-c'
            set i (math $i+1)
            set o_count $flags[$i]
    end
    set i (math $i+1)
end


function o
    cat /dev/urandom | tr -dc 'oO' | head -c $argv[1]
end

if test "$o_count" -ge 0
    set test (math test%512)
    if test -n "$should_rainbow"
        msg $chan (rainbow (o $o_count))
    else
        msg $chan (o $o_count)
    end
else
    msg $chan $nick': read a book'
end
