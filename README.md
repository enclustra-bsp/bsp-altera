# Enclustra Build Environment

Enclustra Build Environment is a tool which allows the user to quickly set up and run Linux on all of the Enclustra modules equipped with Intel (Altera) SoC devices.
It allows the user to choose the desired target, and it downloads all the required binaries, such as the bitstream. It also downloads and compiles software such as U-Boot, Linux, and Buildroot based root file system.

Running the build.sh script without any arguments starts the Build Environment in GUI mode; in GUI mode, the user is prompted to select the desired module and base board combination, and the boot mode and software for later use.

For automating the build process, a command line interface is available.

Please refer to the [user documentation](documentation/1_Introduction.md) for more information on the usage of the build system.

Copyright (c) 2015-2023, Enclustra GmbH, Switzerland
