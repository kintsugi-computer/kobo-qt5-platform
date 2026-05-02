# Kobo QT5 Platform Plugin

Andreas Schaarschmidt's Qt5 platform plugin packaged into an APK for an Alpine chroot on Kobo eReaders.

## Description

This project is used to compile and package 
[Rain92's Kobo Qt5 platform plugin](https://github.com/Rain92/qt5-kobo-platform-plugin)
into an APK installer archive so that it can easily be installed into an 
Alpine chroot on a Kobo eReader.

This project was tested in an Alpine v3.22.4 chroot environment on a Kobo Aura N514. It
was not tested on any other environment.

## Getting Started

### Installing the apk

Download the latest APK file from the Releases page, and install it with the `apk` command.
For instance, from the command-line in an Alpine chroot:

    latest="https://api.github.com/repos/kintsugi-computer/kobo-qt5-platform/releases/latest"
    release="$(wget -O - "${latest}" | /bin/sed -n 's/.*browser_download_url": "\(.*\)"/\1/p')"
    wget "${release}"

    apk add --allow-untrusted kobo-qt5-plugin*.apk

### Compiling and packaging Qt5 platform plugin for Kobo

Follow these minimal steps to compile and package the Qt5 platform plugin for Kobo. Note that this 
does not set up a proper environment for self-hosting APK packages. It just allows the compilation
of the plugin and packaging it into an APK installer archive. The first two steps can be skipped 
if you have already set up a user to compile APK packages.

* Ensure that you are `root` and setup the abuild environment
    * Install the required packages `apk add alpine-sdk linux-headers doas abuild-rootbld git`
    * Create a non-provileged user (replace `username` by the account name) `adduser username`
    * Add the user to the `abuild` group (replace `username` by the account name) `addgroup username abuild`
* Switch to the newly created user 
    * Start a shell as the new user `su - username` 
    * Setup the global git configuration:
        * `git config --global user.name "firstname lastname"`
        * `git config --global user.email "email@addres"`
    * Generate the APK signing keys `abuild-keygen -a -i`. Ignore any message about failing to 
      install the keys in `/etc/apk/keys`.
* Install the build dependencies:
	* Download and install the [`kobo-fbink`](https://github.com/kintsugi-computer/kobo-fbink) package
	* `doas apk add qt5-qtbase-dev libevdev-dev i2c-tools-dev libxkbcommon-dev libinput-dev mtdev-dev`
* Build the package
    * Clone this repository in the user's homedirectory: `cd ; git clone https://github.com/kintsugi-computer/kobo-fbink.git`
    * Enter the directory and update the Git submodules `git submodule update --init`. There is no need
      for `--recursive` as the build relies on the `kobo-fbink` and the dev library packages.
    * Make the project by invoking `make`. This will take a while (some 30 minutes on a Kobo Aura N514), 
      and `abuild` will display some errors about the untrusted signing key, the failure to create an 
      index for the package repository and the missing package for makedepends. However, the apk archive 
      will have been created in `/home/username/packages/username/armhf` and copied to the current 
      directory.

Please note that the approach taken here does not follow standard APK packaging practices. It uses 
a git submodule to retrieve the source code as there is no easily accessible tar file release of
the Kobo platform plugin, and it abuses the `prepare()` stage to execute the compilation.

