#!/bin/ksh

export PATH=":/tmp:/net/mmx/bin:/net/mmx/mnt/app/armle/usr/bin$PATH"
export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/mnt/eso/lib:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib
export IPL_CONFIG_DIR=/etc/eso/production

#GLOBALS
XXD="${2}/apps/sbin/xxd" # not on any unit
TEE="${2}/apps/sbin/tee" # /net/mmx/usr/bin
#BC="${2}/apps/sbin/bc" # /net/mmx/mnt/app/armle/usr/bin
SED="${2}/apps/sbin/sed" # /net/mmx/mnt/app/armle/usr/bin
DD="${2}/apps/sbin/dd" # /net/mmx/bin
PC="${2}/apps/sbin/pc" # /net/mmx/mnt/app/eso/bin/apps/pc
LOG="${2}/backup/logs/aio_log.txt"

mount -uw ${2}
mount -uw /net/mmx/mnt/app
touch $LOG

echo "[finalScriptSequence] running..." | $TEE -a $LOG

#Remove Swdlautorun.txt from SD to avoid update loop
mv -f ${2}/Swdlautorun.txt ${2}/_Swdlautorun.txt 2>> $LOG
echo "-- Swdlautorun.txt disabled" | $TEE -a $LOG

#Replace ExceptionList and remove related SWDL meta files
cp ${2}/common/tools/0/default/ExceptionList.txt /HBpersistence/FEC 2>> $LOG
rm -f /net/rcc/mnt/efs-persist/FEC/ExceptionList.txt.SWDL.compatibility.txt
rm -f /net/rcc/mnt/efs-persist/FEC/ExceptionList.txt.SWDL.version.txt
rm -f /net/rcc/mnt/efs-persist/SWDL/MainUnit-version2.txt.SWDL.compatibility.txt
echo "-- ExceptionList restored and SWDL cleaned" | $TEE -a $LOG

#Clear illeagl and withdrawn FECs
rm -f /net/rcc/mnt/efs-persist/FEC/IllegalFecContainer.fec 2>> $LOG
rm -f /net/rcc/mnt/efs-persist/FEC/WithdrawnFecContainer.fec 2>> $LOG
echo "-- Illegal and withdrawn FECs removed" | $TEE -a $LOG

#Adaptions CP/AA/GEM
on -f mmx $PC b:0:3221356628:7.7 1 2>> $LOG
on -f mmx $PC b:0:3221356628:8.0 1 2>> $LOG
on -f mmx $PC b:0:3221356628:8.5 1 2>> $LOG
on -f mmx $PC i:0:1343769792 3 2>> $LOG
on -f mmx $PC b:0:3221356557:0 1 2>> $LOG
echo "-- CarPlay, AndroidAuto, Mirrorlink and Development Mode activated" | $TEE -a $LOG

#WLAN ON
on -f mmx $PC i:0:0x50186008 1 2>> $LOG
on -f mmx $PC i:28442848:514 1 2>> $LOG
on -f mmx $PC b:0:3221356628:8.2 1 2>> $LOG
echo "-- WLAN activated" | $TEE -a $LOG

#Region US = 2
REGION=2
#byte_3_Country_Navigation
on -f mmx $PC i:0:0x50180CFF 2 $REGION 2>> $LOG
#SDS Region Flag
on -f mmx $PC b:0:0xC0020054:9 $REGION 2>> $LOG
#byte_24_Navigation_System
on -f mmx $PC i:0:0x50186004 1 2>> $LOG
#enable Navigation in variant_2
on -f mmx $PC i:0x286f058c:6 1 2>> $LOG
echo "-- Navigation activated" | $TEE -a $LOG

sleep 2
on -f mmx $PC b:0:1 0 2>> $LOG
echo "-- Write coding to persistence" | $TEE -a $LOG
sleep 2

#Add M.I.B. link to GEM
on -f mmx rm -rf /eso/hmi/engdefs/z_Launcher-sda0.esd 2>> $LOG
on -f mmx ln -s /net/mmx/fs/sda0/esd/Launcher-sda0.esd /eso/hmi/engdefs/z_Launcher-sda0.esd 2>> $LOG
echo "-- M.I.B link to GEM installed" | $TEE -a $LOG

#Enable AndroidAuto and Boardbook button image support on POG11
IMAGE="/net/mmx/mnt/app/eso/hmi/lsd/images/30/"
AA="3000087.png"
BB="3000042.png"
checksum_AA="fe015c909f6d0ffd44052c9b47db4ee2ffef03b3"
checksum_BB="73a1e3e7f19a490a10e4d0f0c119a2b58b0ad686"

echo -ne "Enable AndroidAuto and Boardbook button image support on POG11\n"
checksum_unit="$(/net/rcc/usr/bin/sha1sum $IMAGE$AA | awk '{print $1}')"
	if [ $checksum_AA = $checksum_unit ]; then
		#mount -uw /net/mmx/mnt/app
		mv $IMAGE$AA $IMAGE"bck_"$AA
		mv $IMAGE$BB $IMAGE"bck_"$BB
		cp -r ${2}/mod/images/POG11/$AA $IMAGE$AA
		cp -r ${2}/mod/images/POG11/$BB $IMAGE$BB
		mount -ur /net/mmx/mnt/app
		echo -ne "-- AA button fix applied\n" | $TEE -a $LOG
	else
		echo -ne "File checksum does not match. No patch applied\n" | $TEE -a $LOG
		if [ -f $IMAGE"bck_"$AA ]; then
			echo -ne "Button images are already installed\n" | $TEE -a $LOG
		else
			echo -ne "Share M.I.B log with M.I.B developers\n" | $TEE -a $LOG
			echo -ne "File checksum: "$checksum_unit"\n" | $TEE -a $LOG
			sleep 1
		fi
	fi

#Build custom FecContainer.fec
echo "-- Start building custom FecContainer.fec" | $TEE -a $LOG
GetFecContainer () {
Pointer=8
FECCOUNT=0
FECCOUNTDEC=0
echo -n > /tmp/AddedFecs.tmp
echo -n > /tmp/FecContainer.tmp
echo -n > /tmp/InstalledFecs.tmp
if [[ -n $($DD if=/HBpersistence/FEC/FecContainer.fec bs=1 count=1) ]]; then
$XXD -u -p -c 99999 /HBpersistence/FEC/FecContainer.fec > /tmp/FecContainer.tmp
elif [[ -f /mnt/efs-system/backup/FEC/FecContainer.fec ]]; then
$XXD -u -p -c 99999 /mnt/efs-system/backup/FEC/FecContainer.fec > /tmp/FecContainer.tmp
fi
FecCheck=$($DD if=/tmp/FecContainer.tmp skip=8 bs=2 count=2)
if [[ $FecCheck -ne 1102 ]] && [[ $FecCheck -ne 1107 ]]; then
CreateVCRNVIN
else
VCRNVIN=$($DD if=/tmp/FecContainer.tmp skip=15 bs=2 count=22)
FECCOUNTHEX=$($DD if=/tmp/FecContainer.tmp bs=2 count=1)
FECCOUNTDEC=$((0x$FECCOUNTHEX))
fi
while [[ $FECCOUNTDEC -gt 0 ]]; do
ParseFecContainer
done
CreateNewFecs
}

ParseFecContainer () {
if [[ $($DD if=/tmp/FecContainer.tmp skip=$Pointer bs=2 count=2) = "1102" ]]; then
ParseSingleFec
elif [[ $($DD if=/tmp/FecContainer.tmp skip=$Pointer bs=2 count=2) = "1107" ]]; then
ParseMultiFec
fi
}

ParseSingleFec () {
((Pointer=Pointer+2))
echo $($DD if=/tmp/FecContainer.tmp skip=$Pointer bs=2 count=4) >> /tmp/InstalledFecs.tmp
((Pointer=Pointer+193))
((FECCOUNTDEC--))
}

ParseMultiFec () {
((Pointer=Pointer+34))
FecAmountHEX=$($DD if=/tmp/FecContainer.tmp skip=$Pointer bs=2 count=1)
FecAmountDEC=$((0x$FecAmountHEX))
FecLength=$((FecAmountDEC*4))
((Pointer++))
while [[ $FecAmountDEC -gt 0 ]]; do
echo $($DD if=/tmp/FecContainer.tmp skip=$Pointer bs=2 count=4) >> /tmp/InstalledFecs.tmp
((Pointer=Pointer+4))
((FecAmountDEC--))
done
((Pointer=Pointer+148+FecLength))
((FECCOUNTDEC--))
}

CreateVCRNVIN () {
if [[ -f /tmp/VIN.txt ]]; then
VIN=$($XXD -u -p -s 5 -l 17 /tmp/VIN.txt)
else
VIN=2020202020202020202020202020202020
fi
VCRNVIN=FFFFFFFFFF$VIN
echo -n > /tmp/FecContainer.tmp
}

CreateNewFecs () {
while read FEC; do
grep -iq $FEC /tmp/InstalledFecs.tmp
FecNotPresent=$?
if [[ $FecNotPresent -eq 1 ]] && [[ $FECCOUNT -le 255 ]]; then
((FECCOUNT++))
BuildFec
fi
done < /tmp/FecsToAdd.tmp
FECCOUNTADD=$(echo -n "ibase=10;obase=16;$FECCOUNT" | bc)
while [[ ${#FECCOUNTADD} -lt 2 ]]; do
FECCOUNTADD="0"$FECCOUNTADD
done
echo -n $FECCOUNTADD"000000" | $XXD -r -p > /tmp/NewFecContainer.fec
cat /tmp/AddedFecs.tmp >> /tmp/NewFecContainer.fec
rm -f /HBpersistence/FEC/TempFecContainer.fec
rm -f /HBpersistence/FEC/IllegalFecContainer.fec
rm -f /HBpersistence/FEC/WithdrawnFecContainer.fec
cp /tmp/NewFecContainer.fec /HBpersistence/FEC 2>> $LOG
echo "-- FecContainer.fec written to unit" | $TEE -a $LOG
}

BuildFec () {
while [ ${#VCRNVIN} -lt 44 ]; do
VCRNVIN=$VCRNVIN"20"
done
Date=$(date -t)
if [[ $Date -lt 1624912953 ]]; then
Date=1624912953
fi
Epoch=$(echo -n "ibase=10;obase=16;$Date" | bc)
echo -n "AB0000001102"$FEC"03"$VCRNVIN"00"$Epoch"000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01000000000000000100000003000000FF000000" | $XXD -r -p >> /tmp/AddedFecs.tmp
}

#Parse addFecs.txt
echo -n > /tmp/FecsToAdd.tmp
$SED 's/\r//g' ${2}/common/tools/addFecs.txt > /tmp/addFecs.txt
while read FEC; do
grep -iq $FEC /tmp/FecsToAdd.tmp
FecNotPresent=$?
((16#$FEC)) > /dev/null 2>&1
FecIsHex=$?
if [[ $FecIsHex -eq 0 ]] && [[ ${#FEC} -eq 8 ]] && [[ $FecNotPresent -eq 1 ]]; then
echo $FEC >> /tmp/FecsToAdd.tmp
fi
done < /tmp/addFecs.txt
if [[ -s /tmp/FecsToAdd.tmp ]]; then
GetFecContainer
else
echo "-- No valid Fecs to add found, nothing to do!" | $TEE -a $LOG
exit 1
fi

sync; sync; sync

echo "[finalScriptSequence] completed\n\n"  | $TEE -a $LOG
