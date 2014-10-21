. lib/file.fish
set file (file_file $rest)
if test -n $file -a -f $file
    msg $chan (cat $file | sort -R | head -1)
else
    msg $chan $nick': no such file or command'
end
