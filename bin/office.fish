. lib/opts.fish

set opts (opts_getopts r:d: $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)

set reg
set dereg

set i 1
while test $i -le (count $flags)
    switch $flags[$i]
        case '-r'
            set i (math $i+1)
            set reg $flags[$i]
        case '-d'
            set i (math $i+1)
            set dereg $flags[$i]
    end
    set i (math $i+1)
end

if test -n "$reg"
    msg $chan $nick': '(curl -d "nick=$nick&mac=$reg" "http://magpie.dhcp.io/reg")
else if test -n "$dereg"
    msg $chan $nick': '(curl -d "mac=$dereg" "http://magpie.dhcp.io/dereg")
else
    set around (curl "http://magpie.dhcp.io/plain")
    if test -n "$around"
        msg $chan $nick': '$around
    else
        msg $chan $nick': the office is empty'
    end
end
