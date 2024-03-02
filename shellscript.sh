#!/bin/bash
shopt -s xpg_echo 
##(cmd "shopt" set output format. -s enable, -u disable : enable expg_echo: $ echo "Hello\nworld" --> Hello\nworld; disable expg_echo: $ echo "Hello\nworld" --> Hello world)
# set xv 
## (run in debug mode)


#######################################
#Variable
filenametime1=$(date +"%m%d%Y%H%M%S")

export INPUT_FOLDER='/home/hlai8/Desktop/DE-firstproject/download'
export OUTPUT_FOLDER='/home/hlai8/Desktop/DE-firstproject/output'
export ROOT_FOLDER='/home/hlai8/Desktop/DE-firstproject'
export LOG_FOLDER='/home/hlai8/Desktop/DE-firstproject/log'
export SHELL_SCRIPT_NAME='shell_script'
export LOG_FILE=${LOG_FOLDER}/${SHELL_SCRIPT_NAME}_${filenametime1}.log # output a log with customized format

########################################
#Log rules
exec > >(tee ${LOG_FILE}) 2>$1
# execute the result to LOG_FILE , with error including

########################################
#Part 1 Download

for year in {2020..2022}; 
do wget -N --content-disposition "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&Day=14&timeframe=1&submit= Download+Data" -O ${INPUT_FOLDER}/${year}.csv;
done;
# Downloading the folder and rename it in specific format and location using " -O ${INPUT_FOLDER}/${year}.csv " , also with --content-disposition in front.

RC1=$?
if [ ${RC1} != 0 ]; then
    echo "Error code : ${RC1}, please refer to manual for the reason"
    exit 1 
else 
    echo "Download SUCESSED"
fi

echo "------Download Stage Ended"

# Check and echo error code if there is any.

######################################
#Part 2 Concat

echo " start running Python Script"
python3 ${ROOT_FOLDER}/pythonscript.py

RC1=$?
if [ ${RC1} != 0 ]; then
    echo "Python run failed!"
    echo "Error code : ${RC1}, please refer to manual for the reason"
    exit 1 
else 
    echo "Pythonrun SUCESSED"
fi
fi

echo "------Python Stage Ended"

exit 0