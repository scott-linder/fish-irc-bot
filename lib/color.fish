function color
    if test (count $argv) -eq 1
        echo -n \3$argv[1]
    else
        echo -n \3
    end
end

function random_color
    color (math (random)%16)
end

function rainbow
    for char in (echo $argv[1] | fold -w1)
        random_color
        echo -n $char
    end
    color
end
