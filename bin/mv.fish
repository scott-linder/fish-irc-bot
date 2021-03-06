. lib/file.fish
set names (echo $rest | tr ' ' \n)
if test (count $names) = 2
    set src (chan_file $chan $names[1])
    set dest (chan_file $chan $names[2])
    if test -f $src
        if not test -f $dest
            mv $src $dest
        else
            msg $chan $nick': destination file already exists'
        end
    else
        msg $chan $nick': source file does not exist'
    end
else
    msg $chan $nick': must provide exactly two filenames'
end
