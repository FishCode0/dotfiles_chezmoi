function copy
    if type -q clip.exe
        clip.exe

    else if type -q wl-copy
        wl-copy

    else if type -q xclip
        xclip -selection clipboard

    else if type -q xsel
        xsel --clipboard --input

    else
        echo "No clipboard utility found"
        return 1
    end
end
