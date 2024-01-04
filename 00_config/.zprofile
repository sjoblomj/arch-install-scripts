# Automatically start labwc when logging in
[ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && ./bin/labwc/build/labwc &
