set -l to_chan (clean_chan (echo $rest | sed -n 's/^\([^ ]\+\) .*$/\1/p'))
set -l to_do (echo $rest | sed -n 's/^[^ ]\+ \(.*\)/\1/p')
if test -n "$to_chan" -a -n "$to_do"
    if sudoer $nick $to_chan
        me $to_chan $to_do
    end
else
    msg $chan $nick': invalid syntax'
end
