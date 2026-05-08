function copypath
    if test (count $argv) -eq 0
        pwd | tr -d '\n' | copy
    else
        realpath $argv[1] | tr -d '\n' | copy
    end
end