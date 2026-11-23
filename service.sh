#!/system/bin/sh

RED_LED="/sys/class/leds/red/brightness"
GREEN_LED="/sys/class/leds/green/brightness"
BLUE_LED="/sys/class/leds/blue/brightness"

set_rgb() {
    echo "$1" > "$RED_LED" 2>/dev/null
    echo "$2" > "$GREEN_LED" 2>/dev/null
    echo "$3" > "$BLUE_LED" 2>/dev/null
}

# Holding on to this for now.
clamp() {
    if [ "$1" -lt 0 ]; then echo 0
    elif [ "$1" -gt 255 ]; then echo 255
    else echo "$1"
    fi
}


is_awake() {
    dumpsys power 2>/dev/null | grep -q "mWakefulness=Awake"
}


rgb_cycle() {
    while is_awake; do
        set_rgb 255 70 255
        sleep 1
    done
}

main_loop() {
 
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 1
    done

    while true; do
        if is_awake; then
            rgb_cycle
            set_rgb 0 0 0
        fi
        sleep 1
    done
}


main_loop &
