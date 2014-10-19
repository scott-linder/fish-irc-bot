function file_file -d 'Get filename for given file target'
    set raw $argv[1]
    mkdir -p 'data/file/'
    echo 'data/file/'(echo $raw | tr -d ' ./')
end
