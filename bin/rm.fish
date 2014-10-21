. lib/file.fish
set file (file_file $rest)
if sudoer $nick
    if test -n $file -a -f $file
        rm $file
    else
        msg $chan $nick': no such file'
    end
end
