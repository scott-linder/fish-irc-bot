. lib/file.fish
set file (chan_file $chan $rest)
if sudoer $nick
    if test -n "$file" -a -f $file
        for line in (cat $file)
            msg $chan $line
        end
    end
end
