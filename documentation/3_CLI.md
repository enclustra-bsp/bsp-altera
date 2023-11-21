# Enclustra Build Environment - User Documentation

## Command Line Interface CLI

The build process can be invoked from the command line. All options that are available in the GUI are present on the command line interface as well. A list of the available command line options can be obtained like this:

```
./build.sh --help

usage: tool [-h] [--release ver] [-L] [--list-devices-raw] [-d device] [-l]
            [--list-targets-raw] [-x target] [-f target] [-b target]
            [--custom-build target steps] [--fetch-history target]
            [--list-dev-options] [--list-dev-binaries] [-B file path]
            [--anti-unicorn] [--expert-mode] [-o index] [--generate-project]
            [--build-project project_file] [--build-project-auto project_file]
            [-s cfg] [-c] [-C] [-v]

Enclustra Build Environment

optional arguments:
  -h, --help                    show this help message and exit
  --release ver                 specify release version of the buidscripts
  -L, --list-devices            list all available devices
  --list-devices-raw            list all available devices in a script
                                friendly way
  -d device, --device device    specify device as follows:
                                <family>/<module>/<base_board>/<boot_device>
  -l, --list-targets            list all targets for chosen device
  --list-targets-raw            list all targets for chosen device in a script
                                friendly way
  -x target                     fetch and build specific target
  -f target, --fetch target     fetch specific target
  -b target, --build target     build specific target
  --custom-build target steps   build specific target with specific steps
                                (comma separated)
  --fetch-history target        fetch specific target with history
  --list-dev-options            list all available device options for chosen
                                device
  --list-dev-binaries           list all available binary files for chosen
                                device
  -B file path, --custom-binary file path
                                exchange selected binary file with the one
                                pointed by the path
  --anti-unicorn                disables colored output
  --expert-mode                 expert mode: prepare the environment for
                                building the whole system manually
  -o name, --dev-option name    set device option by name, the default one
                                will be used if not specified
  --generate-project            generate project directory instead of a
                                regular output
  --build-project project_file  build project
  --build-project-auto project_file
                                build project automatically, skip the gui
  -s cfg, --saved-config cfg    use previously saved configuration file
  -c, --clean-all               delete all downloaded code, binaries, tools
                                and built files
  -C, --clean-soft              run clean commands for all specified targets
                                (if available)
  -v, --version                 print version
```


### Build default target for a device

To list all available devices use the following command, it shows all modules, baseboards and boot modes:

```
./build.sh -L

List of available devices:
Mercury_AA1/Mercury_ST1/EMMC
Mercury_AA1/Mercury_ST1/MMC
Mercury_AA1/Mercury_ST1/QSPI
Mercury_AA1/Mercury_PE1/EMMC
..
.
```

To build the default targets of one of the listed devices, call the build.sh script with the `-d` option. This mode requires a valid device specifier in order to locate the device configuration within the targets directory for the specific device, e.g. for the Mercury+ AA1 module on the Mercury ST1 base board in MMC boot mode, the command would look like this:

```
./build.sh -d Mercury_AA1/Mercury_ST1/MMC
```


### Select exact device to build

To build the target for an exact device number (e.g. ME-AA1-270-2I2-D11E-NFX3), use the following command to list all possible device options. It will print out an indexed list of device options.

```
./build.sh -d Mercury_AA1/Mercury_ST1/MMC --list-dev-options

Available options for Mercury_AA1/Mercury_ST1/MMC:
1. ME-AA1-270-3E4-D11E-NFX3
2. ME-AA1-270-2I2-D11E-NFX3
3. ME-AA1-480-2I3-D12E-NFX3 (default)
```

The `-o` option allows the user to choose a device option for the selected device by providing the name of a specific device option.

```
./build.sh -d Mercury_AA1/Mercury_ST1/MMC -x Linux -o ME-AA1-270-3E4-D11E-NFX3
```

If no device option is selected, the default one will be used.


### Select target to build or fetch

To list all the available targets for a selected device, the user needs to add the -l switch to the command, e.g.:

```
./build.sh -d Mercury_AA1/Mercury_ST1/MMC -l

Available targets for Mercury_AA1/Mercury_ST1/MMC:
Default targets are marked with an [*]
U-Boot ()
Buildroot ()
Linux ()
```

The -x option will fetch and build only the selected target. That will fetch and build only the Linux target for the selected device.

```
./build.sh -d Mercury_AA1/Mercury_ST1/MMC -x Linux
```

To only fetch or build a specific target, the user can specify those targets with the -f (fetch) and -b (build) options. It is possible to choose multiple targets. This will fetch Linux, build Buildroot and fetch/build U-Boot.

```
./build.sh -d Mercury_AA1/Mercury_ST1/MMC -f Linux -b Buildroot -x U-Boot
```


### Clean environment

To reset the build environment and delete all downloaded code, binaries, tools and built files, the --clean-all option can be used:

    ./build.sh --clean-all



Last Page: [Graphical User Interface GUI](./2_GUI.md)

Next Page: [Deployment](./4_Deployment.md)
