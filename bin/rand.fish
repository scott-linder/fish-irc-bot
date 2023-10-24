. lib/file.fish
. lib/opts.fish
. lib/color.fish

set opts (opts_getopts r $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)

set should_rainbow

set i 1
while test $i -le (count $flags)
    switch $flags[$i]
        case '-r'
            set should_rainbow 1
    end
    set i (math $i+1)
end

if test $cmd = rrand
    set should_rainbow 1
end

set file (chan_file $chan $rest)
if test -n "$file" -a -f $file
    set line (shuf -n 1 $file)
    if test -n "$should_rainbow"
        msg $chan (rainbow $line)
    else
        msg $chan $line
    end
end
