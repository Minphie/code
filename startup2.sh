#! /bin/bash
source /opt/ros/indigo/setup.bash
source ~/rock2_ws/devel/setup.bash

export ROS_HOSTNAME=10.0.1.100
export ROS_MASTER_URI=http://10.0.1.100:11311

sleep 5s

while [ 1 ]
do
    echo "Start dev scan......"
    echo "Find /dev/video6......."
    if [ 1 ]; then
        echo "the /dev/video6 is exist"
        echo "Find /dev/video7......."
        if [ -c /dev/video7 ]; then
            echo "the /dev/video7 is exist"
            echo "Find /dev/android......."
            if [ -c /dev/ttyS1 ]; then
                echo "the /dev/android is exist"
                echo "Find /dev/dashgo......."
                if [ -c /dev/dashgo ]; then
                    echo "the /dev/dashgo is exist"
                    echo "Find /dev/stm32......."
                    if [ -c /dev/stm32 ]; then
                        echo "the /dev/stm32 is exist"
                        gnome-terminal -x bash -c "rosclean purge"&
                        sleep 1s
                        gnome-terminal -x bash -c "roscore"&
                        sleep 1s
                        gnome-terminal -x bash -c "rosrun rock_nav serial_32_v2.py"&
                        sleep 1s
                        gnome-terminal -x bash -c "roslaunch rock_nav rplidar.launch"&
                        sleep 5s
                        gnome-terminal -x bash -c "roslaunch rock_driver demo.launch"&
                        sleep 1s
                        gnome-terminal -x bash -c "roslaunch /home/firefly/rock2_ws/src/navigation.launch"&
                        sleep 1s
                        gnome-terminal -x bash -c "rosrun communication serialport_android"&
                        sleep 1s
                        gnome-terminal -x bash -c "rosrun web_firefly web_firefly_communication.py"&
                        break
                    else
                        echo "the /dev/stm32 isn't exist"
                    fi
                else
                    echo "the /dev/dashgo isn't exist"
                fi
            else
                echo "the /dev/android isn't exist"
            fi
        else
            echo "the /dev/video7 isn't exist"
        fi
    else
        echo "the /dev/video6 isn't exist"
    fi
    sleep 5s
    clear
done
