set s (curl "http://oeis.org/search?fmt=text&q=$rest" | sed -n 's/^%N \(.*\)/\1/p' | head -1)
if test -n "$s"
    msg $chan $nick': '$s
else
    msg $chan $nick': no such sequence'
end
