#!/bin/bash
make
sudo cp build/bin/linapple /opt/retropie/emulators/linapple
sudo cp res/linapple.conf /opt/retropie/configs/apple2
sudo ln -s /opt/retropie/configs/apple2 /home/pi/.linapple