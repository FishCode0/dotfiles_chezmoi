function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if test -f "$tmp"
        cd (cat "$tmp")
        rm -f "$tmp"
    end
end
