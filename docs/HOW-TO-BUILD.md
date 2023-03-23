How to build LineageOS 18.1 for the Unihertz Atom L and XL
=================================================

This guide is focused on building the ROM under a Linux host environment.

## Setting up the build environment

In general follow one of the many build instructions found at the LineageOS wiki.
For example the instructions for the [Google Nexus 5 aka hammerhead](https://wiki.lineageos.org/devices/hammerhead/build).
Here is a short summing up.

### Install the build packages

To successfully build LineageOS, you’ll need

```bash
sudo apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
```

For Ubuntu versions older than 16.04 (xenial), you’ll need

```bash
sudo apt-get install libwxgtk2.8-dev
```

For Ubuntu versions older than 20.04 (focal), you’ll also need

```bash
sudo apt-get install libwxgtk3.0-dev
```

### Install the platform-tools

Only if you haven’t previously installed adb and fastboot

```bash
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip platform-tools-latest-linux.zip -d ~
```

Update your PATH variable for your environment

```bash
gedit ~/.profile
```

Add the following

```bash
# add Android SDK platform tools to path
if [ -d "$HOME/platform-tools" ] ; then
  PATH="$HOME/platform-tools:$PATH"
fi
```

Then update your environment

```bash
source ~/.profile
```

### Install the repo command

Download the binary and make it executable

```bash
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
```

Update your PATH variable for your environment

```bash
gedit ~/.profile
```

Add the following

```bash
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi
```

Then update your environment

```bash
source ~/.profile
```

### (optional) Install git-lfs for GAPPS support during build

If you want to include GAPPS in the build you need [git-lfs](https://git-lfs.github.com/) otherwise the apk's can't be downloaded.

```bash
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
```

### Configure git

repo requires you to identify yourself to sync Android

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

### (optional) Turn on caching to speed up build

Update your build environment

```bash
gedit ~/.bashrc	
```

Add the following

```bash
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_COMPRESS=1
```

### Initialize the LineageOS source repository

Create the project folder and download the source code

```bash
mkdir -p ~/android/lineage
cd ~/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1 --git-lfs
```

Now let's add this very device repo to the local_manifest

```bash
gedit cd ~/android/lineage/.repo/local_manifests/roomservice.xml
```

Add the following

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="ADeadTrousers/android_device_Unihertz_Atom_LXL" path="device/Unihertz/Atom_LXL" remote="github" revision="master" />
  <project name="ADeadTrousers/android_vendor_mediatek_libfmcust" path="vendor/mediatek/libfmcust" remote="github" revision="master" />
  <!-- For the Atom L model add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_L" path="device/Unihertz/Atom_L" remote="github" revision="master" />
  <!-- For the Atom XL model add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_XL" path="device/Unihertz/Atom_XL" remote="github" revision="master" />
  <!-- For the Atom L region eea add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_L_EEA" path="device/Unihertz/Atom_L_EEA" remote="github" revision="master" />
  <!-- For the Atom XL region eea add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_XL_EEA" path="device/Unihertz/Atom_XL_EEA" remote="github" revision="master" />
  <!-- For the Atom L region tee add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_L_TEE" path="device/Unihertz/Atom_L_TEE" remote="github" revision="master" />
  <!-- For the Atom XL region tee add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_XL_TEE" path="device/Unihertz/Atom_XL_TEE" remote="github" revision="master" />
</manifest>
```

If you want to build with HardwareKeyMapper included add the following to the manifest-tag

```xml
  <project name="ADeadTrousers/HardwareKeyMapper" path="vendor/are/HardwareKeyMapper" remote="github" revision="master" />
```

If you want to build with GAPPS included add the following to the manifest-tag

```xml
  <remote name="opengapps" fetch="https://github.com/opengapps/" />
  <remote name="opengapps-gitlab" fetch="https://gitlab.opengapps.org/opengapps/" />
  <project path="vendor/opengapps/build" name="aosp_build" revision="master" remote="opengapps" />
  <project path="vendor/opengapps/sources/all" name="all" clone-depth="1" revision="master" remote="opengapps-gitlab" />
  <!-- arm64 depends on arm -->
  <project path="vendor/opengapps/sources/arm" name="arm" clone-depth="1" revision="master" remote="opengapps-gitlab" />
  <project path="vendor/opengapps/sources/arm64" name="arm64" clone-depth="1" revision="master" remote="opengapps-gitlab" />
  <project path="vendor/opengapps/sources/x86" name="x86" clone-depth="1" revision="master" remote="opengapps-gitlab" />
  <project path="vendor/opengapps/sources/x86_64" name="x86_64" clone-depth="1" revision="master" remote="opengapps-gitlab" />
```

If you want to build with Magisk included add the following to the manifest-tag

```xml
  <project name="ADeadTrousers/android_vendor_magisk" path="vendor/magisk" remote="github" revision="master" />
```

To finish everything up sync the repo

```bash
cd ~/android/lineage
repo sync --force-sync
```

Apply all the patches that are needed for this deivce

```bash
./device/Unihertz/Atom_LXL/patch/apply.sh
```

## (optional) Configure GAPPS for the device

If you don't want to include GAPPS at all or want to change the apps to be installed

```bash
gedit ~/android/lineage/device/Unihertz/Atom_LXL/gapps_prop.mk
```

[Documentation of the possible settings](https://github.com/opengapps/aosp_build/blob/master/README.md)

## Extracting the vendor blobs

### Use imjtool (formerly known as imgtool) to extract from stock rom files

First follow [the instructions to extract and mount the stock rom files](HOW-TO-EXTRACT_FILES.md) 
(You only need to do the part with super.img)

Then extract all the files we need

```bash
# For the Atom L EEA use
~/android/lineage/device/Unihertz/Atom_L_EEA/extract-files.sh ~/unihertz/extracted
# For the Atom XL EEA use
~/android/lineage/device/Unihertz/Atom_XL_EEA/extract-files.sh ~/unihertz/extracted
# For the Atom L TEE use
~/android/lineage/device/Unihertz/Atom_L_TEE/extract-files.sh ~/unihertz/extracted
# For the Atom XL TEE use
~/android/lineage/device/Unihertz/Atom_XL_TEE/extract-files.sh ~/unihertz/extracted
```

If you get errors during the extraction it's most certainly because of missing access rights. 
The fastest way to counter these is to grant the ownership (chown) of the missing files and the containing directories to your user.

### Use an allready rooted device

If you were able to root your device this is just a small step. Plug in your device and do the follwing

```bash
# For the Atom L EEA use
~/android/lineage/device/Unihertz/Atom_L_EEA/extract-files.sh 
# For the Atom XL EEA use
~/android/lineage/device/Unihertz/Atom_XL_EEA/extract-files.sh
# For the Atom L TEE use
~/android/lineage/device/Unihertz/Atom_L_TEE/extract-files.sh 
# For the Atom XL TEE use
~/android/lineage/device/Unihertz/Atom_XL_TEE/extract-files.sh
```

## Building the rom

Prepare the build

```bash
cd ~/android/lineage
source build/envsetup.sh
# For the Atom L EEA use
breakfast Atom_L_EEA
# For the Atom XL EEA use
breakfast Atom_XL_EEA
# For the Atom L TEE use
breakfast Atom_L_TEE
# For the Atom XL TEE use
breakfast Atom_XL_TEE
```

Do the actual build

```bash
cd ~/android/lineage
ccache -M 50G
croot
# For the Atom L EEA use
brunch Atom_L_EEA
# For the Atom XL EEA use
brunch Atom_XL_EEA
# For the Atom L TEE use
brunch Atom_L_TEE
# For the Atom XL TEE use
brunch Atom_XL_TEE
```

## Updating the sorces (at a later time)

Make sure everything is up-to-date

```bash
cd ~/android/lineage
repo sync --force-sync
```

Re-apply all the patches that are needed for this deivce

```bash
./device/Unihertz/Atom_LXL/patch/apply.sh
```

If you changed the settings of TWRP and GAPPS sadly you need to redo them now.

Also don't forget to sync git-lfs if you included GAPPS

```bash
repo forall -c git lfs pull
```
