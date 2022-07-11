# MHI2_US_POG11_K5186_1 MU1476 AIO 

Custom **A**ll **I**n **O**ne FW update based on latest Porsche firmware available - MHI2_US_POG11_K5186 MU1476.<br />
Usable for all MHI2 US POG11 based MIB2 units

ℹ️ Custom all-in-one FW update based on [metainfo2 exploit](/doc/metainfo2txt-exploit-VcFdFs4rds).<br />
:warning: Read full artivle before using this update.<br />
<br />
**Last update 10.07.2022**<br />

# Features
1. Based on latest `MHI2_US_POG11` firmware<br />
2. BOSE Sound System update **disabled** and removed from update<br />
3. Automatic starting FW update after plugging in SD<br />
4. Patched IFS-Root (FEC, VCRN & Component Protection patch) will be used during the installation.<br />
5. FecContainer.fec will be extended with missing FECs:<br />
    * `00030000`,`00040100`, `00050000`,`00070100`, `00070200`, `00030000`, `06310099`,`00060100`,`00060500`,`00060700`,`00060800`, `00060900`, `00060A00`<br />
    * addFecs.txt in /common/tools/ can be adjusted as needed. Change add FECS with e.g. notepad.<br />
6. CarPlay and AndroidAuto will be enabled during the installation<br />
7. Developer Mode with GEM (hidden Green Engineering Menu) will be enabled during the installation<br />
    *No need for OBD tools like PIWIS to enable it.<br />
9. WLAN will be enabled - required for e.g. [Porsche Track Precision App](https://github.com/harman-f/MHI2_US_POG11_K5186_1-MU1476-AIO/edit/main/README.md#track-precision-app)<br />
10. Navigation will be enabled on units which do not have it activated from factory<br />
    * All MHI2 based units - like PCM 4 - are capable to run NAvigation!
    * GPS antenna might be missing and has to be retrofitted<br />
    * Check with M.I.B in GEM if antenna is installed<br />
11. AndroidAuto button fix will be applied<br />
12. M.I.B. - More Incredible Bash will be enabled to run from SD<br />
13. [M.I.B. AIO version](https://github.com/Mr-MIBonk/M.I.B._More-Incredible-Bash) - with AIO tailored functions - will be available directly from AIO SD card
    * SVM fix, backup/restore functions, some basic coding checks and more<br />
14. Basic system backup will be run during installation process, before any changes to unit are applied<br />
15. Full LOG of installation process is stored on SD card folder /backup/logs/<br />

## Requirements

* Porsche US POG11 with PCM4/MIB2 system (any `MHI2_US_POG11_XXXXX`)
* `MHI2_US_POG11_P2138*,MHI2_US_POG11_P2145*,MHI2_US_POG11_P3276*,MHI2_US_POG11_P3290*,MHI2_US_POG11_P3300*,MHI2_US_POG11_K3300*,MHI2_US_POG11_P4151*,MHI2_US_POG11_P4173*,MHI2_US_POG11_K4186*,MHI2_US_POG11_P4255*,MHI2_US_POG11_P5004*,MHI2_US_POG11_P5039*,MHI2_US_POG11_P5103*,MHI2_US_POG11_P5109*,MHI2_US_POG11_K5109*,MHI2_US_POG11_P5127*,MHI2_US_POG11_K5127*,MHI2_US_POG11_P5150*,MHI2_US_POG11_P5159*,MHI2_US_POG11_K5159*,MHI2_US_POG11_P5177*,MHI2_US_POG11_K5177*,MHI2_US_POG11_K5184*,MHI2_US_POG11_K5186*`
* Quality SD card, `8GB` capacity or more, **FAT32** formatted

## How to install

1. Format SD card with **FAT32** file system.<br />
2. [Download MHI2_US_POG11_K5186_1 MU1476 AIO](https://mibsolution.one/#/1/9/MHI2%20-%20HARMAN/Firmware/Porsche/US)).
   * ℹ️ Use [download manager](https://mibwiki.one/share/99dda9a7-06e2-4673-a5df-2ea7e0eb18cb) to speed up downloading from mibsolution.one
3. Extract the content of the AIO package to the root directory of the FAT32 formatted SD card.<br />
4. Power PCM 4 system up by pressing right knob<br />
   * Connect external charger to car<br />
   * Power failure during FW update will brick your unit<br />
   * Turn all not required power consumers off<br />
   :warning: In case your car has kessy make sure that the car key will not leave the vehicle during the firmware update procedure.<br />
5. Insert the AIO SD card in `SD 1` port.<br />
6. **Firmware update will start automatically within 60 seconds. Do not do anything.**
   * If nothing happens within 2 minutes, double check SD Card for FAT32 formatting and proper file structure.<br />
7. Wait for the update to be installed - **be patient**.<br />
   * System will reboot a few times during the firmware update procedure. The screen can stay off or stuck on the Porsche logo for several seconds.<br />
   * Depending on the start firmware version the update will take between 10 - 40 minutes (this is why an external charger is required.<br />
8. The installation will finish with a 'Summary of devices' screen of all installed packages and their installation status.<br />
   * Updates packages have to show Y(es)<br />
   * Packages will be different based on original FW version<br />
   * Exit this screen by pressing 'Continue' on screen<br />
   * ![image](https://user-images.githubusercontent.com/98130152/178356101-c8008fb4-85e1-4750-b1c1-91a7fdfe2e2f.png)<br />
9. Last screen will be 'Start backup documentation'<br />
   * Exit this screem by pressing 'Cancel backup documentation' on screen<br />
   * ![image](https://user-images.githubusercontent.com/98130152/178356543-8b00f7b8-f5cd-4203-9b03-5eb8331a6b50.png)<br />
   * This is as it should be<br />
   * Unit will reboot one more time<br />
10. Unit boots up into normal user interface<br />
11. Enter GEM and run [SVM fix in M.I.B](https://github.com/harman-f/MHI2_US_POG11_K5186_1-MU1476-AIO/edit/main/README.md#svm-fix)<br />
   * This will run for a few minutes and the unit will reboot one last time<br />
12. AIO FW update is completly done<br />
   * Have fun and explore the new functions!<br />

### Installation on 911
[![image](http://img.youtube.com/vi/QPRqR47_9qo/0.jpg)](https://www.youtube.com/watch?v=QPRqR47_9qo)

### Installation on Cayman 718
[![image](http://img.youtube.com/vi/n_7fZUXAqEw/0.jpg)](https://www.youtube.com/watch?v=n_7fZUXAqEw)

## Bose Sound System update

**Standard install has BOSE updates REMOVED.**<br />

By default, the AIO FW will not update the Bose amplifier firmware. `metainfo2.txt` was prepared to skip this component.<br />
Updating will require parameterization of the amplifier, which must be completed with PIWIS or at the dealer.<br />

:warning: Without the parameterization you will have no sound.<br />

If you wish to update Bose you can use different `metainfo2.txt`, which is included into the IO package.

1. Remove `metainfo2.txt`<br />
2. Rename `metainfo2-Bose.txt` to `metainfo2.txt`<br />
3. Run the update<br />
4. Perform parametrization<br />

## SVM fix

Use built-in M.I.B AIO version to run SVM fix.<br />
Enter GEM (CAR+TUNER buttons on home screen) and select function.<br />
![image](https://user-images.githubusercontent.com/98130152/178356676-128374db-d50b-4f4f-981b-377d0ef83e5d.png)<br />

# Map updates to the latest US maps:<br />

1. **[Download latest maps here](https://mibsolution.one/#/1/15/MHI2(Q))**<br />
   * ![image](https://user-images.githubusercontent.com/98130152/178357825-0470613c-2826-42f6-909b-af264189f39e.png)<br />
   * ℹ️ Use [download manager](https://mibwiki.one/share/99dda9a7-06e2-4673-a5df-2ea7e0eb18cb) to speed up downloading from mibsolution.one<br />
2. Copy files to the root of a FAT32 32GB SD card<br />
3. Install via Software Update on your unit<br />

# Retrofit GPS Antenna 

Use M.I.B to check if your car already has a GPS antenan built in.
![image](https://user-images.githubusercontent.com/98130152/178350343-4a692a0c-06b4-4141-9705-950873dc6d68.png)

If NO antenna is installed you have several options to retrofit one.
You can place the antenna directly behind your PCM screen. 

## GPS Hardware

### Original Porsche antenna
1. Antenna - Part number: 7PP035504A - 30$
* ![image](https://user-images.githubusercontent.com/98130152/178358449-a20a2bb1-b9c8-45c7-8369-82937ad7138d.png)
* [e.g. buy here](https://partecha.com/autoparts-categories/accessories-17/aerial-3023/porsche-macan-95b-gps-navigation-antenna-27614)
2. Fakra cable to connect antenna to PCM unit
* Cable - Part number: 99161202250 - 60$
* [e.g. buy here](https://www.porscheatlantaperimeterparts.com/products/Porsche/CONNECTING-LINE-A-Connector-wire-GPS-Navigation-System-Antenna-Cable--1-2012-16-GPS-Navigation-System-Antenna-Cable/10089660/99161202250.html)

### "Cheap" antennas - 15$
https://www.amazon.com/dp/B0107LPEWK
https://www.amazon.com/dp/B006AKVX2S

ℹ️ Some of these antennas are shown in GEM as OPEN, but still work normally.

### Original VW antenna - 90$
https://parts.vw.com/p/volkswagen__/GPS-Antenna-Assembly/73283683/000051502G.html
![image](https://user-images.githubusercontent.com/98130152/178349282-88ace2cb-cfea-4770-9ab1-02c0faa0354c.png)
![image](https://user-images.githubusercontent.com/98130152/178349306-4cd05a53-ce45-4397-a8cd-96aa3a0909b0.png)

# Track Precision App
[![image](http://img.youtube.com/vi/w3avv2_bbM8/0.jpg)](https://www.youtube.com/watch?v=w3avv2_bbM8)

[![image](http://img.youtube.com/vi/B5HERxITtMY/0.jpg)](https://www.youtube.com/watch?v=B5HERxITtMY)

![image](https://user-images.githubusercontent.com/98130152/178163930-4bae2ff0-357f-4928-98ab-f2b33e3e83b7.png)

# Retrofit Navigation display in Cluster

Follow this Link for details: <https://rennlist.com/forums/718-gts-4-0-gt4-gt4rs-spyder-25th-anniversary/1307811-oem-navigation-retrofit-diy.html>

## Fakra/LVDS cable to connect cluster

### On Cluster
![attachments](https://user-images.githubusercontent.com/98130152/178358958-c64be4cb-0e8f-44dd-9989-f4214af8a541.png)

### On 5F
![attachments-1](https://user-images.githubusercontent.com/98130152/178358975-e6cfe49a-96b7-4cd7-a9f1-6a1e8436478f.png)


## OEM cable

You need to buy the LVDS cable part number 9P3-979-001
![attachments](https://user-images.githubusercontent.com/98130152/178359065-e584611f-530c-4bc4-b51f-94237542d5fc.png)
![attachments-1](https://user-images.githubusercontent.com/98130152/178359086-cf85a114-8be4-4f7c-90af-a63af116c988.png)


## Custom cable

* Male type Z 90° angle
* Male type Z straight
* 1m length


<https://de.aliexpress.com/item/1005003094375962.html>
![attachments](https://user-images.githubusercontent.com/98130152/178359357-6c2cd986-bc65-4a1d-93c5-4cd9ccf84aa6.png)
Price: \~8 USD incl. shipping


Fakra connector type Z will fit in any socket.

