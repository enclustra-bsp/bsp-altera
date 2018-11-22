Change Log
==========

Version 1.7 (2018-11)
---------------------

* bumped Linux kernel version to 4.15
* bumped U-Boot version to V2018.05
* bumped Buildroot version to V2018.05.1
* bumped GCC version to 7.2.0
* updated documentation:
    - added new "Updating the binaries" section
    - updated build script help message
* bug fixes

Version 1.6 (2018-03-21)
------------------------

* rootfs overlays mechanism (for example for installing kernel modules into buildroot rootfs)
* proper binaries versioning using a new templates mechanism in config files
* automatic detection for number of threads to build on (based on host CPU)
* minor project mode fixes
* bug fixes
* updated user documentation
* U-Boot changes:
    - bumped to 2017.07
    - cadence QSPI driver fixed
    - added commands for runtime sd/emmc muxing for Mars MA3 module
    - added commands for runtime qspi/sd/emmc muxing for Mercury+ AA1 module
    - minor bug fixes
* finished Mercury+ AA1 support in Linux and U-Boot (added support for all possible boot modes)
* new Mercury+ AA1 variants support (rev 2):
    - Arria 10 SX480, Speed Grade E1
    - Arria 10 SX480, Speed Grade I2
    - Arria 10 SX270, Speed Grade E3
    - Arria 10 SX270, Speed Grade I2
* Mars MA3 support:
    - Cyclone V A5, Speed Grade C8
    - Cyclone V C6, Speed Grade I7

Version 1.5 (2017-06-28)
------------------------

* dropped container repositories
* added support for custom binaries
* GUI improvements
* offline building support
* bug fixes
* added support for MAC address reading from ATSHA EEPROM
* added Mercury AA1 support
    - currently only MMC boot is supported
    - U-Boot is delivered as a precompiled binary
* bug fixes in U-Boot
* Linux kernel bug fixes
