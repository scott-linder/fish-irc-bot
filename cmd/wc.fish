. lib/file.fish
set file (file_file $rest)
if test -n $file -a -f $file
    msg $chan $nick': '(cat $file | wc -l)' lines'
end
