. lib/file.fish
set file (file_file $rest)
if test -n "$file" -a -f $file
    msg $chan (nl -w2 $file | tr -d \n)
else
    msg $chan $nick': no such file'
end
