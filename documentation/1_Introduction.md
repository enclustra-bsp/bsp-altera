# Enclustra Build Environment - User Documentation


## Table of content

* [Introduction](./1_Introduction.md)
    - [Version Information](./1_Introduction.md#version-information)
    - [Build Environment](./1_Introduction.md#build-environment)
        - [Prerequisites](./1_Introduction.md#prerequisites)
        - [Directory Structure](./1_Introduction.md#directory-structure)
        - [General Build Environment Configuration](./1_Introduction.md#general-build-environment-configuration)
    - [Supported Devices](./1_Introduction.md#supported-devices)
* [Graphical User Interface GUI](./2_GUI.md)
* [Command Line Interface CLI](./3_CLI.md)
* [Deployment](./4_Deployment.md)
    * [SD Card Partitioning](./4_Deployment.md#sd-card-paratitioning)
    * [Storage Multiplexing](./4_Deployment.md#storage-multiplexing)
    - [SD Card](./4_Deployment.md#sd-card)
    - [eMMC Flash](./4_Deployment.md#emmc-flash)
    - [QSPI Flash](./4_Deployment.md#qspi-flash)
* [Project mode](./5_Project_Mode.md)
* [Updating the binaries](./6_Binaries_Update.md)
* [FAQ](./7_FAQ.md)
    - [How to script U-Boot?](./7_FAQ.md#how-to-script-u-boot)
    - [How can the flash memory be programmed from Linux?](./7_FAQ.md#how-can-the-flash-memory-be-programmed-from-linux)
    - [Read serial number of module](./7_FAQ.md/#read-serial-number-of-module)
    - [Configure SI5338 clock generator on Mercury+ PE1 and Mercury+ ST1 base board](./7_FAQ.md/#configure-si5338-clock-generator-on-mercury-pe1-and-mercury-st1-base-board)
* [Known Issues](./8_Known_Issues.md)


## Introduction

This is the user documentation for the Enclustra Build Environment project. It can be used to create a bootable Linux image for Enclustra's SoC modules.

### Version Information

Date | Rev | Author | Changes
--- | --- | --- | --- 
2015-05-08 | 1.0 | Karol Gugala | Buildsystem description
2015-05-11 | 1.1 | Aleksandra Szawara | Language check
2015-07-06 | 1.2 | Aurelio Lucchesi | Minor corrections
2015-11-20 | 1.3 | Tomasz Gorochowik | Major reorganization
2016-06-21 | 1.4 | Tomasz Gorochowik | Project mode section
2017-06-23 | 1.5 | Maciej Mikunda | Updates for release v1.5
2018-03-21 | 1.6 | Mariusz Glebocki | Updates for release v1.6
2018-11-22 | 1.7 | Wojciech Tatarski | Updates for release v1.7
2019-02-22 | 1.8 | Joanna Brozek | Updates for release v1.8
2023-11-03 | 1.9 | Andreas Bürkler | Update to newer version


###  Build Environment

This chapter describes the usage of the build environment. The whole build environment is written in Python. Its internal functionality is determined by ini files placed in a specific directory layout.


#### Prerequisites

The build environment was tested on following host Linux distributions:

- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS

To run the build script a Python 2 interpreter is required.

The build environment requires additional software to be installed as listed below:

Tool |  Comments
--- | ---
dialog |  Required only in the GUI mode
make |
git |
tar |
unzip |
curl |
wget |
bc |
libssl-dev |
patch |
rsync |
autoconf |  Required to build a buildroot rootfs
g++ |  Required to build a buildroot rootfs
gcc |
flex |
bison |
u-boot-tools |

The required packages can be installed with the following commands:

```
sudo apt update
sudo apt install python2 dialog make git tar unzip curl wget bc libssl-dev patch rsync autoconf g++ gcc flex bison u-boot-tools
```


### Directory Structure

The build environment is designed to work with a specific directory structure depicted below:

    |-- bin
    |-- binaries
    |-- buildscripts
    |-- sources
    |   |-- target_submodule_1
    |   |-- target_submodule_2
    |   |-- target_submodule_3
    |   |-- target_submodule_4
    |-- targets
    |   |-- Module_1
    |       |-- BaseBoard_1
    |       |-- BaseBoard_2
    |   |-- Module_2
    |       |-- BaseBoard_1
    |-- target_output

Folder | Function
--- | ---
bin | Remote toolchains installation folder.
binaries | Additional target binaries download folder.
sources | master_git_repository clone folder. It contains submodule folders.
buildscripts | Build system executable files.
targets | Target configurations are placed here.
target_output | Folders generated during the build process, which contain the output files after a successful build of every specifc target.

> **_Important:_**  By default, the target output folders are named according to this folder naming scheme:
> `out_<timestamp>_<module>_<board>_<bootmode>.`
> The default name can be overwritten during the build process.


### General Build Environment Configuration

Environment settings are stored in the enclustra.ini file in the main directory of the build environment. Before starting the build script, one may need to adjust the general settings of the build environment by editing this file. One of the most crucial setting is the number of build threads used in a parallel. This parameter is set in the [general] section by changing the nthreads key. Additionally, parameters in the [debug] section allow the user to adjust the logging settings:

- If the debug-calls option if set to true, the output of all external tool calls (such as make, tar etc.) will be displayed in the terminal.
- If the quiet-mode option is set to true, the build log of the targets will not be printed to the terminal, only informations about actual build state will be shown. This option does not affect the build-logfile option.
- If the build-logfile option is set to a file name, the build environment will write the whole build log output to that file. If the option is not set, the output will not be logged.
- If the break-on-error option is set to true, the build environment will interrupted on the first error. Otherwise the build environment will only print an error message and continue to work on a next available target.


## Supported Devices

Family          | Module , Revision | Base boards
--------------- | ----------------- | --------------
Intel Cyclone V | Mercury  SA1 , R3 | Mercury PE1 / PE3 / ST1
Intel Cyclone V | Mercury+ SA2 , R1 | Mercury PE1 / PE3 / ST1
Intel Arria 10  | Mercury+ AA1 , R2 | Mercury PE1 / PE3 / ST1

> **_Note:_**  Since release 1.9, Mars MA3, Mercury+ AA1 R1 and Mercury SA1 R1 and R2 are no longer supported.

Next Page: [Graphical User Interface GUI](./2_GUI.md)
