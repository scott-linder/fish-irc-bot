. lib/file.fish
set args (echo $rest | tr ' ' \n)
set pattern $args[1]
set file (chan_file $chan $args[2])
if test -f "$file"
    msg $chan (grep -i $pattern $file | sort -R | head -1)
else
    msg $chan $nick': no such file'
end
