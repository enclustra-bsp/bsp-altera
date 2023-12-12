# Enclustra Build Environment - User Documentation

## Updating the binaries

### Changes in the FPGA design

If a user wants to modify the FPGA design, the binaries can be updated in two ways:

1. By changing the path to custom binaries in the graphical user interface. See step 12 in [GUI](./2_GUI.md).

2. By adding the custom binary as argument for the command line interface. E.g.

For Arria 10 devices:

```
./build.sh -d Mercury_AA1/Mercury_ST1/MMC -B handoff <absolute-path>/hps_isw_handoff -B bitstream.periph.rbf <absolute-path>/bitstream.periph.rbf -B bitstream.core.rbf <absolute-path>/bitstream.core.rbf
```

For Cyclone V devices:

```
./build.sh -d Mercury_SA1/Mercury_ST1/MMC -B handoff <absolute-path>/hps_isw_handoff -B fpga.rbf <absolute-path>/refdes.rbf
```

3. By using the project mode:

   1. Enable project mode in the Enclustra Build Environment.

   2. Copy to the output directory (the directory with the boot sources created by the Enclustra Build Environment):

      - the new `*.rbf` file (if you introduced changes to the FPGA logic),

      - the new Quartus handoff directory (if you introduced changes to the HPS).

   3. Run the Enclustra Build Environment.

   4. The new SPL preloader and or bitstream image will be generated in the output directory.


### Changes in U-boot, Linux or Buildroot

If a user wants to modify U-boot, Linux or Buildroot, the following steps can be performed:

1. Go to the ‘sources/’ directory, where U-boot, Linux and Buildroot repositories are placed.

2. Introduce your changes in the selected repository.

3. Run the Enclustra Build Environment in project mode to compile and build the modified sources.

4. Replace the files on the target device, depending on which repository you changed:

   - altera-linux: the `devicetree.dtb` and the kernel image file (`uImage`).

   - altera-uboot: the `boot.scr`, the SPL (`u-boot-splx4.sfp` or `u-boot-with-spl.sfp`
) and the `u-boot.img` file.

   - buildroot-rootfs: the `rootfs.tar` archive (or the `uramdisk`, depending on which boot device you choose).


Last Page: [Project mode](./5_Project_Mode.md)

Next Page: [FAQ](./7_FAQ.md)
