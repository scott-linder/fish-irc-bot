. lib/file.fish
. lib/sed.fish
set dir (chan_dir $chan)
if test -n "$dir" -a -d $dir
    if test -n "$rest"
        msg $chan (ls (chan_dir $chan) | sed -n "/^"(sed_escape_regexp $rest)"/p")
    else
        msg $chan (ls (chan_dir $chan) | tr \n ' ')
    end
else
    msg $chan $nick': no such directory'
end
