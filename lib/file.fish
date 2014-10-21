function file_file -d 'Get filename for given file target'
    set raw $argv[1]
    mkdir -p 'var/file/'
    echo 'var/file/'(echo $raw | tr -d ' ./')
end
