function copycmd
    history | head -n 1 | tr -d '\n' | copy
end