# WSL detection

set -g IS_WSL 0

if grep -qi microsoft /proc/version
    set -g IS_WSL 1
end

# Wayland

set -g IS_WAYLAND 0

if test "$XDG_SESSION_TYPE" = "wayland"
    set -g IS_WAYLAND 1
end
