# MHI2_US_POG11_K5186_1 MU1476 AIO 


:warning: This is already successfully tested on several units. Still, some bugs might be hidden :)<br />
Custom all-in-one FW update based on [metainfo2 exploit](/doc/metainfo2txt-exploit-VcFdFs4rds).<br />
:warning: Read all before updating.<br />
<br />
**Last update 10.07.2022**<br />

# Features

1. All in one update from any `MHI2_US_POG11` firmware directly to `MHI2_US_POG11_K5186_1`. No need to manually edit EEPROM. No need to disable or loop MOST.Automatic starting FW update after plugging in SD<br />
2. Patched IFS-Root (FEC & CP patch) will be used during the installation.<br />
3. FecContainer will be adjusted with missing FECs (`00030000`,`00040100`, `00050000`,`00070100`, `00070200`, `00030000`, `06310099`,`00060100`,`00060500`,`00060700`,`00060800`, `00060900`, `00060A00`) during the installation.<br />
    * addFecs.txt in /common/tools/ can be adjusted as needed. Change add FECS with e.g. notepad.<br />
4. CarPlay and AndroidAuto will be enabled during the installation.<br />
5. Developer Mode with GEM (hidden Green Engineering Menu) will be enabled during the installation. No need for OBD tools like PIWIS.<br />
6. WLAN will be enabled - required for e.g. Porsche Track Precision App<br />
7. Navigation will be enabled on units which do not have activated it.<br />
    1. GPS antenna might be missing and has to be retrofitted.<br />
    2. Check with M.I.B in GEM if antenna is installed.<br />
8. AndroidAuto button fix will be applied<br />
9. M.I.B. - More Incredible Bash will be enabled to run from SD<br />
10. [M.I.B. AIO version](https://github.com/Mr-MIBonk/M.I.B._More-Incredible-Bash) - with reduced functions - will be available directly from FW SD card
    * SVM fix, Backup functions, some basic coding checks<br />
11. BOSE Sound System update disabled<br />

## Requirements

* Porsche US G11 with MMI MIB2 system (any `MHI2_US_POG_XXXXX`)
  *`MHI2_US_POG11_P2138*,MHI2_US_POG11_P2145*,MHI2_US_POG11_P3276*,MHI2_US_POG11_P3290*,MHI2_US_POG11_P3300*,MHI2_US_POG11_K3300*,MHI2_US_POG11_P4151*,MHI2_US_POG11_P4173*,MHI2_US_POG11_K4186*,MHI2_US_POG11_P4255*,MHI2_US_POG11_P5004*,MHI2_US_POG11_P5039*,MHI2_US_POG11_P5103*,MHI2_US_POG11_P5109*,MHI2_US_POG11_K5109*,MHI2_US_POG11_P5127*,MHI2_US_POG11_K5127*,MHI2_US_POG11_P5150*,MHI2_US_POG11_P5159*,MHI2_US_POG11_K5159*,MHI2_US_POG11_P5177*,MHI2_US_POG11_K5177*,MHI2_US_POG11_K5184*,MHI2_US_POG11_K5186*`
* Quality SD card, `8GB` capacity or more ([how to check SD card](/doc/sd-card-testing-Gxi8EpfXTg)),
* Update package (download: [https://mibsolution.one/#/1/9/MHI2 - HARMAN/Firmware/Porsche/US](https://mibsolution.one/#/1/9/MHI2%20-%20HARMAN/Firmware/Porsche/US)).

## How to install

1. Format SD card with `FAT32` file system.<br />
2. Extract the content of the All-In-One package to the root directory of the FAT32 formatted SD card.<br />
3. Turn the ignition on (accessory), and wait for the PCM system to boot up. Connecting an external charger is recommended.<br />
:warning: Make sure that the car key will not leave the vehicle during the firmware update procedure (learn more about [Kessy and updates](/doc/kessy-updates-JeN8RUuHyK)).<br />
4. OPTIONAL: Can prevent some issues. Restore factory settings by going to `MENU` → `Setup MMI` → `Factory Settings` → `Select all entries` → `Restore factory settings`.<br />
5. Wait for about 20 seconds for the factory settings to be done.<br />
6. Place the FAT32 SD card with files in `SD 1` port.<br />
7. **Firmware update will start automatically within 60 seconds. Do not do anything.** If nothing happens within 2 minutes, double check SD Card for FAT32 formatting and proper file structure.<br />
8. Wait for the update to be installed. It will take some time, the system will reboot a few times during the firmware update procedure. The screen can stay off or stuck on the Porsche logo for several seconds. Be patient and wait. Depending on the start FW the updates typically take between 10 - 40 minutes (this is why an external charger can be handy).<br />

The whole update process can be found in these YT videos:

### Installation on 911
[![image](http://img.youtube.com/vi/QPRqR47_9qo/0.jpg)](https://www.youtube.com/watch?v=QPRqR47_9qo)

### Installation on Cayman 718
[![image](http://img.youtube.com/vi/n_7fZUXAqEw/0.jpg)](https://www.youtube.com/watch?v=n_7fZUXAqEw)

## Bose Sound System update

**Standard install is not inclusive of BOSE updates.**<br />

By default, this procedure will not update the Bose amplifier firmware. `metainfo2.txt` was prepared to skip this component, the updated amplifier will require parameterization which must be completed with PIWIS or at the dealer.<br />

:warning: Without the parameterization you will have no sound.<br />

If you wish to update Bose you can use different `metainfo2.txt` to do it.

1. Remove `metainfo2.txt`<br />
2. Rename `metainfo2-Bose.txt` to `metainfo2.txt`<br />
3. Run the update<br />
4. Perform parametrization afterwards<br />

## SVM

Use built-in M.I.B AIO version to run SVM fix.<br />

Enter GEM (CAR+TUNER buttons on home screen) and select function.<br />

# Map updates to the latest US maps:<br />


:::info
Use [download manager](/doc/mibsolutionone-fix-download-speed-sxBSYsX5Qq) to speed up downloading from mibsolution.one

:::

Get latest maps:

<https://mibsolution.one/#/1/15/MHI2(Q)>

Copy files to the root of a FAT32 SD card and install via Software Update in the PCM.


# Track Precision App
[![image](http://img.youtube.com/vi/w3avv2_bbM8/0.jpg)](https://www.youtube.com/watch?v=w3avv2_bbM8)

[![image](http://img.youtube.com/vi/B5HERxITtMY/0.jpg)](https://www.youtube.com/watch?v=B5HERxITtMY)

![image](https://user-images.githubusercontent.com/98130152/178163930-4bae2ff0-357f-4928-98ab-f2b33e3e83b7.png)

# Retrofit Navigation display in Cluster

Follow this Link for details:

<https://rennlist.com/forums/718-gts-4-0-gt4-gt4rs-spyder-25th-anniversary/1307811-oem-navigation-retrofit-diy.html>


## Fakra/LVDS cable to connect cluster


On Cluster

On 5F


### OEM cable

You need to buy the LVDS cable part number 9P3-979-001


### Custom cable

* Male type Z 90° angle
* Male type Z straight
* 1m length


<https://de.aliexpress.com/item/1005003094375962.html>


Price: \~8 USD incl. shipping


Fakra connector type Z will fit in any socket.

