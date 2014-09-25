if test -n $rest
    echo $rest >> 'data/quotes'
    msg $chan $nick': OK'
else
    msg $chan $nick': '(sort -R 'data/quotes' | head -1)
end
