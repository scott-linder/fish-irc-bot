. lib/file.fish
set args (echo $rest | tr ' ' \n)
set pattern $args[1]
set file (file_file $args[2])
if test -f "$file"
    msg $chan (grep $pattern $file | sort -R | head -1)
else
    msg $chan $nick': no such file'
end
