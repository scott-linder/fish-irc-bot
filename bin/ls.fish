. lib/file.fish
set dir (chan_dir $chan)
if test -n "$dir" -a -d $dir
    msg $chan (ls (chan_dir $chan) | tr \n ' ')
else
    msg $chan $nick': no such directory'
end
