# !/bin/bash
# conf.sh
# FOR: Changing psmouse: resolution, rate, and resync time; and e1000: copybreak

PASSWORD=sysprog2019

changeres() {
    echo 'Resolution is resolution of cursor in dpi'
    read -p 'New Resolution (in dpi): ' res
    echo $PASSWORD | sudo -S modprobe -r psmouse
    echo $PASSWORD | sudo -S modprobe psmouse resolution=$res
    echo The resolution of the mouse is now: $(cat /sys/module/psmouse/parameters/resolution)
    read -p 'Press [Enter] key to continue...'
    mainmenu
}

changerate() {
    echo 'Rate is how many reports to the computer in seconds'
    read -p 'New rate (in seconds): ' rate
    echo $PASSWORD | sudo -S modprobe -r psmouse
    echo $PASSWORD | sudo -S modprobe psmouse rate=$rate
    echo The rate of the mouse is now: $(cat /sys/module/psmouse/parameters/rate)
    read -p 'Press [Enter] key to continue...'
    mainmenu
}

changeresynctime() {
    echo 'Resync time is the idle time for the mouse before resync in seconds'
    read -p 'New resync time (in seconds): ' resynctime
    echo $PASSWORD | sudo -S modprobe -r psmouse
    echo $PASSWORD | sudo -S modprobe psmouse resync_time=$resynctime
    echo The resync time of the mouse is now: $(cat /sys/module/psmouse/parameters/resync_time)
    read -p 'Press [Enter] key to continue...'
    mainmenu
}

changecb() {
	read -p 'New Copybreak value: ' cb
	echo $PASSWORD | sudo -S modprobe -r e1000
	echo $PASSWORD | sudo -S modprobe e1000 copybreak=$cb
	echo The ethernet copybreak is now: $(cat /sys/module/e1000/parameters/copybreak)
	read -p 'Press [Enter] key to continue...'
	mainmenu
}

mouse() {

    echo '================================================='
    echo Current Mouse Resolution: $(cat /sys/module/psmouse/parameters/resolution)
    echo '================================================='
    echo Current Mouse Rate: $(cat /sys/module/psmouse/parameters/rate)
    echo '================================================='
    echo Current Resync Time: $(cat /sys/module/psmouse/parameters/resync_time)
    echo '================================================='


    COLUMNS=12
    PS3='Choose which parameter you wish to reconfigure: '
    options=("Resolution" "Rate" "Resync Time" "Back")
    select opt in "${options[@]}"
    do
        case $opt in
            "Resolution")
                changeres
                ;;
            "Rate")
                changerate
                ;;
            "Resync Time")
                changeresynctime
                ;;
            "Back")
                mainmenu
                ;;
            *)
        esac
    done
}

ethernet() {

    echo '================================================='
    echo Current Ethernet Copybreak: $(cat /sys/module/e1000/parameters/copybreak)
    echo '================================================='

    COLUMNS=12
    PS3='Choose which parameter you wish to reconfigure: '
    options=("Copybreak" "Back")
    select opt in "${options[@]}"
    do
        case $opt in
            "Copybreak")
                changecb
                ;;
            "Back")
                mainmenu
                ;;
            *)
        esac
    done
}

mainmenu() {

    echo '================================================='
    echo 'Welcome to PID Wilson'
    echo '================================================='

    COLUMNS=12
    PS3='Choose which parameter you wish to reconfigure: '
    options=("Mouse" "Ethernet" "Exit Script")
    select opt in "${options[@]}"
    do
        case $opt in
            "Mouse")
                mouse
                ;;
            "Ethernet")
                ethernet
                ;;
            "Exit Script")
                echo 'Exiting Script'
                read -p 'Press [Enter] key to continue...'
                exit
                ;;
            *)
        esac
    done
}

mainmenu
