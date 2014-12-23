. lib/file.fish
if test -n "$rest"
    set string (echo $rest | sed -n 's/\(.*\)>>.*/\1/p')
    set raw_file (echo $rest | sed -n 's/.*>>\(.*\)/\1/p')
    if test -n "$raw_file"
        set file (chan_file $chan $raw_file)
        echo $string >> $file
    else
        msg $chan $rest
    end
else
    me $chan 'crickets'
end
