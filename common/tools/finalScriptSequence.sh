#!/bin/ksh

# change this file to run any command, script or binary from SD
# no need to touch metainfo2.txt as this is outside of its reach
# final script  run time is set to 300s in metainfo2.txt
# if you need more time extend FinalScriptMaxTime = XX
# add echo to output debugging information to RCC log on UART

echo "[finalScriptSequence] Cool stuff found and executing..."

export GEM=1
export SWDLAUTORUN=1 # allows Swdlautorun.txt in root of SD during SWDL process

echo "Runnung basic backup --------------------"
${2}/apps/backup -b
echo "Runnung AIO generic script --------------"
${2}/apps/aio_generic -all
#echo "Runnung AIO special script -------------"
#${2}/apps/aio_special -all
echo "Runnung POG11 button patch script --------------"
${2}/apps/addimage -pog11on -noboot

echo "[finalScriptSequence] Cool stuff DONE"

