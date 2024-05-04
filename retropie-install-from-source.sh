#!/bin/bash
make
sudo cp build/bin/linapple /opt/retropie/emulators/linapple
# sudo ln -s /opt/retropie/configs/apple2 /home/pi/.linapple
cp retropie/emulators.cfg /opt/retropie/configs/apple2
# cp Master.dsk /opt/retropie/configs/apple2
cp res/linapple.conf /opt/retropie/configs/apple2
# cat retro-pie-notes.txt

