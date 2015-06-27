. lib/opts.fish

set base_url "http://magpie.dhcp.io"

set opts (opts_getopts r:d:l $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)

set reg
set dereg
set list

set i 1
while test $i -le (count $flags)
    switch $flags[$i]
        case '-r'
            set i (math $i+1)
            set reg $flags[$i]
        case '-d'
            set i (math $i+1)
            set dereg $flags[$i]
        case '-l'
            set list 1
    end
    set i (math $i+1)
end

if test -n "$reg"
    msg $chan $nick': '(curl -d "nick=$nick&mac=$reg" "$base_url/reg")
else if test -n "$dereg"
    msg $chan $nick': '(curl -d "nick=$nick&mac=$dereg" "$base_url/dereg")
else if test -n "$list"
    msg $chan $nick': '(curl -d "nick=$nick" "$base_url/list")
else
    set around (curl "$base_url/plain")
    if test -n "$around"
        msg $chan $nick': '$around
    else
        msg $chan $nick': no user machines active'
    end
end
