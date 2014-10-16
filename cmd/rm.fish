. lib/file.fish
set file (file_file $rest)
if test -n $file -a -f $file
    if contains $nick $ADMINS
        rm $file
    end
else
    msg $chan $nick': no such file'
end
