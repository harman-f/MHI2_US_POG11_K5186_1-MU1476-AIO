#!/bin/ksh

# change this file to run any command, script or binary from SD
# no need to touch metainfo2.txt as this is outside of its reach
# final script  run time is set to 30s in metainfo2.txt
# if you need more time extend FinalScriptMaxTime = XX
# add echo to output debugging information to RCC log on UART

echo "[finalScriptSequence] Cool stuff found and executing..."

export GEM=1

/net/mmx/fs/sda0/apps/aio -all

echo "[finalScriptSequence] Cool stuff DONE"

