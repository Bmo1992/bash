#!/bin/bash

# Author: bmo
# - Program demonstrates the distances between the planets in our solar 
#   system. { not perfectly to scale but very rough }
#   Each new line printed represents 1/10th of an AU { This is roughly 
#   equivilant of 9 million miles }
#   The AU ( Astronomical Unit ) is the average distance between the Sun and the Earth
#   The distance for each body is based off it's Semi-major axis 
#   Note that the semi-major axis is NOT the average between aphelion and perihelion 

lineIndex=1

planetPrint ()
{
    echo $1 " ---- " $2 $3
    let lineIndex+=1
    sleep 1
}

echo "THE SUN"
sleep 1
until [ $lineIndex -ge 680 ];
do
    if [ $lineIndex -eq 4 ];
    then
       planetPrint "MERCURY" "0.38 AU"
    elif [ $lineIndex -eq 7 ];
    then
        planetPrint "VENUS" "0.7 AU"
    elif [ $lineIndex -eq 10 ];
    then
        planetPrint "EARTH" "1 AU"
    elif [ $lineIndex -eq 15 ];
    then
        planetPrint "MARS" "1.5 AU"
    elif [ $lineIndex -eq 29 ];
    then
        planetPrint "CERES" "2.9 AU" " ---> dwarf planet"
    elif [ $lineIndex -eq 52 ];
    then
        planetPrint "JUPITER" "5.2 AU"
    elif [ $lineIndex -eq 95 ];
    then
        planetPrint "SATURN" "9.5 AU"
    elif [ $lineIndex -eq 192 ];
    then
        planetPrint "URANUS" "19.2 AU"
    elif [ $lineIndex -eq 301 ];
    then
        planetPrint "NEPTUNE" "30.11 AU"
    elif [ $lineIndex -eq 394 ];
    then
        planetPrint "PLUTO" "39.48 AU" " ---> dwarf planet"
    elif [ $lineIndex -eq 457 ];
    then
        planetPrint "MAKEMAKE" "45.7 AU" " ---> dwarf planet"
    elif [ $lineIndex -eq 677 ];
    then
        planetPrint "ERIS" "67.7 AU" " ---> dwarf planet"
    else
        echo
        let lineIndex+=1
        sleep 1
    fi

done


unset lineIndex
unset -f planetPrint
