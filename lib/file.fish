function sanitize_path -d 'Remove path separators'
    set raw $argv[1]
    echo $raw | tr -d ' ./'
end

function chan_dir -d 'Get dirname for given file target'
    set chan $argv[1]
    echo 'var/file/'(sanitize_path $chan)
end

function chan_file -d 'Get filename for given file target'
    set chan $argv[1]
    set raw $argv[2]
    set dir (chan_dir $chan)
    mkdir -p $dir
    echo $dir'/'(sanitize_path $raw)
end
