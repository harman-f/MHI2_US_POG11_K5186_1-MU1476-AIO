This is a custom MHI2_US_POG11_K5186_1 MU1476 FW update file with some extras ;)

Automated FW install function.
Just plug preparedSD card into unit.

PLEASE NOTE: Start of automatic FW update can take up to 1-2 minutes after plugging SD card in.

Manual:
https://github.com/harman-f/MHI2_US_POG11_K5186_1-MU1476-AIO#readme

All-In-One features:
- Automatic starting FW update after plugging in SD
- BOSE update disabled
- Patched IFS-Root (FEC & CP patch) will be used during the installation.
- FecContainer will be adjusted with missing FECs during the installation including code for latest maps (073000EE).
  - addFecs.txt in /common/tools/ can be adjusted as needed. Change add FECS with e.g. notepad.
- CarPlay and AndroidAuto will be enabled during the installation.
- Developer Mode with GEM (hidden Green Engineering Menu) will be enabled during the installation. No need for OBDeleven, VCDS, VCP.
- WLAN will be enabled - required for e.g.  Porsche Track Precision App
- Navigation will be enabled
- AndroidAuto button fix will be applied
- Basic backup will be run during installation before any chnages to units coding is applied
- M.I.B. - More Incredible Bash will be enabled to run from SD
- M.I.B. AIO version - with reduced functions - will be available directly from FW SD card
  - SVM fix, Backup functions, some basic cosing checks

Version: 20220723