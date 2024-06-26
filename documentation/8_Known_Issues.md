# Enclustra Build Environment - User Documentation

## Known Issues

### 1. Protection bits are set in QSPI flash

#### Affected hardware:

All Enclustra modules equipped with a S25FL512S device (all product models of Mercury+ AA1, Mercury SA1 and Mercury+ SA2).

#### Description

It can happen that all bits of the configuration register 1 of the QSPI flash device are set. One potential cause is when the power supply is turned off during a write command to this register. This register contains a one time programmable bit that defines the reset status of the block protection flags. When this bit is set by accident, the flash device is write protected after power up. As workaround a patch was added to U-Boot and Linux to clear these protection flags.

:warning: If the block protection feature of the QSPI flash device is enabled on purpose, this feature needs to be disabled.

### 2. SD Card access is not reliable

#### Affected hardware:

This issue was observed on Mercury SA1 and Mercury+ AA1 module equipped on Mercury ST1 base board.

#### Description

Linux does not boot or gets stuck while booting. Sometimes the SD Card stops working after Linux is up and running.

### 3. AA1 Linux is limited to 2 Gbyte DDR memory size

#### Affected hardware

All Arria 10 modules equipped with more than 2 Gbyte DDR of memory connected to the HPS:

- ME-AA1-480-2I3-D12E-NFX3

#### Description

The memory size is limited in U-Boot to max. 2 Gbyte. Therefore, only 2 Gbyte is available for U-Boot and Linux. However, the upper 2Gbyte can still be accessed by the FPGA fabric.

### 4. I2C frequency is wrong in U-Boot

#### Affected hardware

All Intel modules.

#### Description

In U-Boot, the I2C frequency is configured to be 100kHz. The frequency changes to 400kHz after "i2c probe" is executed. I2C gets reinitialized when probing fails (when "I2C probe" probes a non existent address), which changes the bus frequency.

### 5. USB host mode does not work in U-Boot

#### Affected hardware

All Mercury+ AA1 product models on PE1, ST1 and PE3 baseboards.

#### Description

USB host mode does not work in U-Boot because the U-Boot USB driver does not support overriding the mode dictated by the USB ID signal.

### 6. Root file system image grows with each build

#### Affected hardware

All builds with EBE are affected.

#### Description

When multiple builds are created in the same bsp-altera directory, the rootfs size is growing with each completed build. This is a problem for QSPI boot, because the rootfs size grows bigger than the QSPI flash size.
The issue is caused by kernel modules which are copied as overlay to the root file system. Each time the kernel gets rebuilt, a new set of kernel modules is copied to the root file system without deleting the already existing ones. As workaround, all subdirectories in `sources/buildroot-rootfs/output/target/lib/modules` can be deleted before a new build is started.

Last Page: [FAQ](./7_FAQ.md)
