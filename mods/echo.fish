. lib/file.fish
if test -n $rest
    set string (echo $rest | sed -n 's/\(.*\)>.*/\1/p')
    set file (file_file (echo $rest | sed -n 's/.*>\(.*\)/\1/p'))
    if test -n $file
        echo $string > $file
    else
        msg $chan $rest
    end
else
    me $chan 'crickets'
end
