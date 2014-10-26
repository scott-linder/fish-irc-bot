msg $chan (curl "http://oeis.org/search?fmt=text&q=$rest" | sed -n 's/^%N \(.*\)/\1/p' | head -1)
