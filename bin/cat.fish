. lib/file.fish
set file (chan_file $chan $rest)
if test -n "$file" -a -f $file
    msg $chan (cat $file | sort -R | head -1)
end
