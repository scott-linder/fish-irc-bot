if test -n $rest
    echo $rest >> 'data/quotes'
    msg $chan $nick': OK'
else
    msg $chan (sort -R 'data/quotes' | head -1)
end
