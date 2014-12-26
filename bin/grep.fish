. lib/file.fish
. lib/opts.fish

set opts (opts_getopts ci $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)

set -l pattern (echo $rest[1..-2])
set -l file (chan_file $chan $rest[-1])

if test -n "$pattern" -a -n "$file" -a -f "$file"
    switch $status
        case 0
            msg $chan (grep $flags $pattern $file | sort -R | head -1)
        case 1
            msg $chan $nick': no matching lines'
        case '*'
            msg $chan $nick': grep error'
    end
else
    msg $chan $nick': invalid pattern or file'
end
