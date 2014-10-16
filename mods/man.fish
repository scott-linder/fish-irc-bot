if test -n $rest
    set topic (echo $rest | tr -cd '[:alpha:]')
    set file man/$topic.txt
    if test -f $file
        msg $chan $nick': '(cat $file)
    else
        msg $chan $nick": no manual available for \"$topic\""
    end
else
    msg $chan $nick': '(cat man/man.txt)' | topics: '(find man/ -type f -follow | sed -n 's#^man/\(.*\).txt$#\1#p' | tr \n ' ') 
end
