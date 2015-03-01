. lib/opts.fish

set opts (opts_getopts gla:d: $rest)
set sep (opts_find_sep $opts)
set flags (opts_flags $sep $opts)
set rest (opts_rest $sep $opts)

set globals
set locals
set add
set delete

set i 1
while test $i -le (count $flags)
    switch $flags[$i]
        case '-g'
            set globals 1
        case '-l'
            set locals 1
        case '-a'
            set i (math $i+1)
            set add $flags[$i]
        case '-d'
            set i (math $i+1)
            set delete $flags[$i]
    end
    set i (math $i+1)
end

set local_sudoers etc/sudoers.d/$chan
if sudoer $nick $chan
    if test -z "$flags"
        msg $chan $nick": Aquaman says you're cool."
    end

    if test -n "$add"
        echo $add >> $local_sudoers
        sort -u $local_sudoers -o $local_sudoers
    end

    if test -n "$delete"
        sed -i /$delete/d $local_sudoers
    end

    if test -n "$globals"
        set sudoers (cat etc/sudoers | tr \n ' ')
        msg $chan "global sudoers: $sudoers"
    end

    if test -n "$locals"
        if test -f $local_sudoers
            set sudoers (cat $local_sudoers | tr \n ' ')
            if test -n "$sudoers"
                msg $chan "channel is privileged, with local sudoers: $sudoers"
            else
                msg $chan "channel is privileged, with no local sudoers"
            end
        else
            msg $chan "channel is unprivileged"
        end
    end
end
