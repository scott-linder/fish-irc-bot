function karma_file -d 'Get filename for given karma target'
    mkdir -p 'data/karma/'
    echo 'data/karma/'(echo $rest | md5sum | awk '{ print $1 }')
end

function karma_get -d 'Get karma for given target'
    set -l file (karma_file $argv[1])
    if [ -e $file ]
        cat $file
    else
        echo '0'
    end
end

function karma_modify -d 'Change karma for given target'
    set -l file (karma_file $argv[1])
    set -l math_ops $argv[2..-1]
    if [ -e $file ]
        set -l new (math (cat $file) $math_ops)
        echo $new > $file
    else
        echo (math '0' $math_ops) > $file
    end
end
