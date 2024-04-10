# Enclustra Build Environment - User Documentation

## FAQ

### U-Boot Environment

U-Boot is using variables from the default environment. Moreover, the boot scripts used by U-Boot also rely on those variables. If the environment was changed and saved earlier, U-Boot will always use these saved environment variables on a fresh boot, even after changing the U-Boot environment. To restore the default environment, run the following command in the U-Boot command line:

```
env default -a
```

This will not overwrite the stored environment but will only restore the default one in the current run. To permanently restore the default environment, the `saveenv` command has to be invoked.

> **_Note:_**  A `*** Warning - bad CRC, using default environment` warning message that appears when booting into U-Boot indicates that the default environment will be loaded.

Following table shows where the environment is stored depending on the boot mode.

Boot storage | Offset            | Size [bytes]
------------ | ----------------- | ---
MMC          | partition 1 (FAT) | 0x80000
eMMC         | partition 1 (FAT) | 0x80000
QSPI         | 0x180000          | 0x80000


### How to script U-Boot?

All U-Boot commands can be automated by scripting, so that it is much more convenient to deploy flash images to the hardware.

For example, QSPI deployment:

Put the following commands as plain text to a file `cmd.txt`:

```
sf probe

echo "SPL"
mw.b 0 0xFF ${size_spl}
tftpboot 0 u-boot-splx4.sfp
sf update 0 ${qspi_offset_addr_spl} ${filesize}

echo "U-Boot"
mw.b 0 0xFF ${size_u-boot}
tftpboot 0 u-boot.img
sf update 0 ${qspi_offset_addr_u-boot} ${filesize}

echo "U-Boot Script"
mw.b 0 0xFF ${size_boot-script}
tftpboot 0 boot.scr
sf update 0 ${qspi_offset_addr_boot-script} ${filesize}

echo "Devicetree"
mw.b 0 0xFF ${size_devicetree}
tftpboot 0 devicetreee.dtb
sf update 0 ${qspi_offset_addr_devicetree} ${filesize}

echo "Bitstream"
mw.b 0 0xFF ${size_bitstream}
tftpboot 0 bitstream.itb # fpga.rbf for Cyclone V devices
sf update 0 ${qspi_offset_addr_bitstream} ${filesize}

echo "Kernel"
mw.b 0 0xFF ${size_kernel}
tftpboot 0 uImage
sf update 0 ${qspi_offset_addr_kernel} ${filesize}

echo "Rootfs"
mw.b 0 0xFF ${size_rootfs}
tftpboot 0 uramdisk
sf update 0 ${qspi_offset_addr_rootfs} ${filesize}

run qspiboot
```

Then generate an image `cmd.img` and put it onto the TFTP server on the host computer like following.

```
mkimage -T script -C none -n "QSPI flash commands" -d cmd.txt cmd.img
cp cmd.img /tftpboot
```

And finally, load the file on the target platform in U-boot and execute it, like this:

```
setenv ipaddr 192.168.1.10
setenv serverip 192.168.1.1
tftpboot 0x10000000 cmd.img
source 0x10000000
```


### How can the flash memory be programmed from Linux?

In order to program a flash memory from Linux, a script like the following one can be used. - All required files need to be present in the current folder. They can be loaded via TFTP or from USB drive / SD card.

```
#!/bin/sh

getsize ()
{
    local  size=`ls -al $1 | awk '{ print $5 }'`
    echo "$size"
}

SPL_FILE="u-boot-splx4.sfp"
UBOOT_FILE="u-boot.img"
SCRIPT_FILE="boot.scr"
DEVICETREE_FILE="devicetree.dtb"
BITSTREAM_FILE="bitstream.itb"
KERNEL_FILE="uImage"
ROOTFS_FILE="uramdisk"

SPL_OFFSET=0x0
UBOOT_OFFSET=0x100000
SCRIPT_OFFSET=0x200000
DEVICETREE_OFFSET=0x280000
BITSTREAM_OFFSET=0x300000
KERNEL_OFFSET=0x1000000
ROOTFS_OFFSET=0x2000000

# erase flash device
flash_erase /dev/mtd0 0 0x4000000

# write SPL
FILESIZE=`getsize ${SPL_FILE}`
echo writing SPL file ${SPL_FILE} size ${FILESIZE}
mtd_debug write /dev/mtd0 ${SPL_OFFSET} ${FILESIZE} ${SPL_FILE}

# write U-Boot
FILESIZE=`getsize ${UBOOT_FILE}`
echo writing U-Boot file ${UBOOT_FILE} size ${FILESIZE}
mtd_debug write /dev/mtd0 ${UBOOT_OFFSET} ${FILESIZE} ${UBOOT_FILE}

# write U-Boot script
FILESIZE=`getsize ${SCRIPT_FILE}`
echo writing U-Boot script file ${SCRIPT_FILE} size ${FILESIZE}
mtd_debug write /dev/mtd0 ${SCRIPT_OFFSET} ${FILESIZE} ${SCRIPT_FILE}

# write devicetree
FILESIZE=`getsize ${DEVICETREE_FILE}`
echo writing devicetree ${DEVICETREE_FILE} size ${FILESIZE}
mtd_debug write /dev/mtd0 ${DEVICETREE_OFFSET} ${FILESIZE} ${DEVICETREE_FILE}

# write bitstream
FILESIZE=`getsize ${BITSTREAM_FILE}`
echo writing bitstream file ${BITSTREAM_FILE} size ${FILESIZE}
mtd_debug write /dev/mtd0 ${BITSTREAM_OFFSET} ${FILESIZE} ${BITSTREAM_FILE}

# write Linux kernel
FILESIZE=`getsize ${KERNEL_FILE}`
echo writing Linux kernel file ${KERNEL_FILE} size ${FILESIZE}
mtd_debug write /dev/mtd0 ${KERNEL_OFFSET} ${FILESIZE} ${KERNEL_FILE}

# write rootfs
FILESIZE=`getsize ${ROOTFS_FILE}`
echo writing rootfs file ${ROOTFS_FILE} size ${FILESIZE}
mtd_debug write /dev/mtd0 ${ROOTFS_OFFSET} ${FILESIZE} ${ROOTFS_FILE}
```

Just make the script executable and execute it like this:

```
chmod +x flash.sh
./flash.sh
```


### Read serial number of module

The serial number of the module can be read by following command:

    cat /sys/bus/i2c/devices/0-0064/serial

The serial number is reported as follows:

    248173

Note that this is only supported on modules equipped with an Atmel EEPROM (Mercury+ SA2, Mercury+ AA1).


### Configure SI5338 clock generator on Mercury+ PE1 and Mercury+ ST1 base board

The U-Boot driver `<bsp-altera>/sources/altera-uboot/drivers/misc/si5338_config.c` adds support to configure the SI5338 clock generator device. To enable the configuration, follow the steps below:

1. Create a configuration with Skyworks [ClockBuilder Pro software](https://www.skyworksinc.com/Application-Pages/Clockbuilder-Pro-Software) and export the C code header file.
2. Copy the exported header file `Si5338-RevB-Registers.h` to `<bsp-altera>/sources/altera-uboot/drivers/misc` directory.
3. Make following change to the file `<bsp-altera>/sources/altera-uboot/configs/socfpga_enclustra_*_defconfig`:

       CONFIG_SI5338_CONFIGURATION=y

Note that the file to be modified depends on the module and boot mode. One of the following files needs to be chosen:

- socfpga_enclustra_mercury_aa1_defconfig
- socfpga_enclustra_mercury_sa1_mmc_defconfig
- socfpga_enclustra_mercury_sa1_qspi_defconfig
- socfpga_enclustra_mercury_sa2_mmc_defconfig
- socfpga_enclustra_mercury_sa2_qspi_defconfig


Last Page: [Updating the binaries](./6_Binaries_Update.md)

Next Page: [Known issues](./8_Known_Issues.md)
