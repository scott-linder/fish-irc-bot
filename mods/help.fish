if test -z $rest
    msg $chan "hello $nick, I am fish, the friendly interactive bot. I know how to: "(find mods/ -type f -follow | sed -n 's#^mods/\(.*\).fish$#'$leader'\1#p' | tr \n ' ')
else
    set topic (echo $rest | tr -cd '[:alpha:]')
    set file help/$topic.txt
    if test -f $file
        msg $chan $nick': '(cat $file)
    else
        msg $chan $nick": no help available for \"$topic\""
    end
end
