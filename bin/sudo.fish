. lib/opts.fish

set opts (opts_getopts lDa:d: $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)

set list
set add
set delete

set i 1
while test $i -le (count $flags)
    switch $flags[$i]
        case '-l'
            set list 1
        case '-D'
            set unmod 1
        case '-a'
            set i (math $i+1)
            set add $flags[$i]
        case '-d'
            set i (math $i+1)
            set delete $flags[$i]
    end
    set i (math $i+1)
end

set sudoers_file etc/sudoers.d/$chan
if sudoer $nick $chan
    if test -n "$add"
        echo $add >> $sudoers_file
        sort -u $sudoers_file -o $sudoers_file
    end

    if test -n "$delete"
        sed -i /$delete/d $sudoers_file
    end

    if test -n "$list"
        if test -f $sudoers_file
            set sudoers (cat $sudoers_file | tr \n ' ')
            if test -n "$sudoers"
                msg $chan $sudoers
            else
                msg $chan "channel is moderated"
            end
        else
            msg $chan "channel is unmoderated"
        end
    end
end
