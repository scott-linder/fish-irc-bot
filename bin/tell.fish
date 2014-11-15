set -l to_chan (clean_chan (echo $rest | sed -n 's/^\([^ ]\+\) .*$/\1/p'))
set -l to_say (echo $rest | sed -n 's/^[^ ]\+ \(.*\)/\1/p')
if test -n "$to_chan" -a -n "$to_say"
    if sudoer $nick
        msg $to_chan $to_say
    end
else
    msg $chan $nick': invalid syntax'
end
