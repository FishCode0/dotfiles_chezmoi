function copy
    if test $IS_WSL -eq 1
        clip.exe
    else
        wl-copy
    end
end