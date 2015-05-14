. lib/file.fish
. lib/opts.fish
. lib/color.fish

set opts (opts_getopts r $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)
set rest (echo $rest)

set should_rainbow

set i 1
while test $i -le (count $flags)
    switch $flags[$i]
        case '-r'
            set should_rainbow 1
    end
    set i (math $i+1)
end

if test -n "$rest"
    set string (echo $rest | sed -n 's/\(.*\) >>.*/\1/p')
    set raw_file (echo $rest | sed -n 's/.* >>\(.*\)/\1/p')
    if test -n "$raw_file"
        set file (chan_file $chan $raw_file)
        if test -n "$should_rainbow"
            echo (rainbow $string) >> $file
        else
            echo $string >> $file
        end
    else
        if test -n "$should_rainbow"
            msg $chan (rainbow $rest)
        else
            msg $chan $rest
        end
    end
else
    me $chan 'crickets'
end
