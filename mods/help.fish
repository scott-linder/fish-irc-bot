if test -z $rest
    msg $chan "Yes, $nick, this is fish. I can "(find mods/ -type f -follow | sed -n 's#^mods/\(.*\).fish$#'$leader'\1#p' | tr \n ' ')'and I can help you with: '(find help/ -type f -follow | sed -n 's#^help/\(.*\).txt$#\1#p' | tr \n ' ')
else
    set topic (echo $rest | tr -cd '[:alpha:]')
    set file help/$topic.txt
    if test -f $file
        msg $chan $nick': '(cat $file)
    else
        msg $chan $nick": no help available for \"$topic\""
    end
end
