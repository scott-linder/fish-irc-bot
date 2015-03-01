. lib/file.fish
set file (chan_file $chan $rest)
if test -n "file" -a -f $file
    msg $chan (cat $file | paste -s -d,)
end
