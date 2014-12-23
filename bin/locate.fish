. lib/file.fish
set file (chan_file $chan $rest)
if test -n "$file" -a -f $file
    msg $chan (readlink -f $file)
else
    msg $chan $nick': no such file'
end
