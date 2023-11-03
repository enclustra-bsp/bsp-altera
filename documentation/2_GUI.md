# Enclustra Build Environment - User Documentation

## Graphical User Interface GUI

In order to build the software for a chosen board using the GUI, please follow these steps:

1. Clone the build environment repository with:

```
git clone https://github.com/enclustra-bsp/bsp-altera.git
```

> **_Note:_**  By default the build script will fetch and build the latest EBE release. With the following command the development branch can be used. Please note that this branch is under development and the resulting software may be unstable.
> `git clone https://github.com/enclustra-bsp/bsp-altera.git -b develop`


2. Change to the bsp-altera directory:

```
cd bsp-altera
```

3. Run the `./build.sh` script.

4. The welcome screen provides basic information about the version of the build environment.

   ![Welcome Screen](./images/welcome_screen.png)

5. Choose the configuration.

   ![Choose config](./images/choose_config_altera.png)

6. Choose the module type.

   ![Module selection](./images/module_altera.png)

7. Choose the base board type.

   ![Baseboard selection](./images/board_altera.png)

8. Choose the boot device.

   ![Baseboard selection](./images/bootmode.png)

9. Choose which targets available for the chosen device family will be fetched.

    ![Choose targets](./images/fetch.png)

10. Choose which targets will be built. On the bottom of the screen a short description of a highlighted target is displayed. In order to use the default target configuration enable the `Load initial ... configuration` checkbox. If changes have been made to the target, disable this checkbox, so that the changes are not overwritten during the build process.

    ![Choose targets to build](./images/build.png)

11. Choose the exact  device.

    ![Choose device](./images/dev_option_altera.png)

12. Customize binaries or use the default ones.

    ![Choose binary](./images/custom_bin_altera.png)

13. Verify all the chosen build parameters.

    ![Summary](./images/summary_altera.png)

14. Choose whether or not to save the configuration for later use.

    ![Save config](./images/save_altera.png)

15. The build environment will fetch and build the chosen targets.


Last Page: [Introduction](./1_Introduction.md)

Next Page: [Command Line Interface CLI](./3_CLI.md)
