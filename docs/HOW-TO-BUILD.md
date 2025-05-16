How to build LineageOS 20.0 for the Unihertz Atom L and XL
=================================================

This guide is focused on building the ROM under a Linux host environment.

## Setting up the build environment

In general follow one of the many build instructions found at the LineageOS wiki.
For example the instructions for the [Google Nexus 5 aka hammerhead](https://wiki.lineageos.org/devices/hammerhead/build).
Here is a short summing up.

### Install the build packages

To successfully build LineageOS, you’ll need

```bash
sudo apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32readline-dev lib32z1-dev liblz4-tool libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
```

For Ubuntu versions older than 16.04 (xenial), you’ll need

```bash
sudo apt-get install libwxgtk2.8-dev
```

For Ubuntu versions older than 20.04 (focal), you’ll also need

```bash
sudo apt-get install libwxgtk3.0-dev
```

For Ubuntu versions older than 24.04 (numbat), you’ll also need

```bash
sudo apt-get install lib32ncurses5-dev libncurses5 libncurses5-dev
```

For Ubuntu versions starting from 24.04 (numbat), you’ll need

```bash
sudo apt-get install libncurses6 libncurses-dev
sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
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
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0
```

Now let's add this very device repo to the local_manifest

```bash
gedit cd ~/android/lineage/.repo/local_manifests/roomservice.xml
```

Add the following

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="ADeadTrousers/android_device_Unihertz_Atom_LXL" path="device/Unihertz/Atom_LXL" remote="github" revision="lineage-20.0r" />
  <project name="ADeadTrousers/android_vendor_mediatek_libfmcust" path="vendor/mediatek/libfmcust" remote="github" revision="master" />
  <!-- For the Atom L model add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_L" path="device/Unihertz/Atom_L" remote="github" revision="lineage-20.0" />
  <!-- For the Atom XL model add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_XL" path="device/Unihertz/Atom_XL" remote="github" revision="lineage-20.0" />
  <!-- For the Atom L region eea add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_L_EEA" path="device/Unihertz/Atom_L_EEA" remote="github" revision="lineage-20.0" />
  <!-- For the Atom XL region eea add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_XL_EEA" path="device/Unihertz/Atom_XL_EEA" remote="github" revision="lineage-20.0" />
  <!-- For the Atom L region tee add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_L_TEE" path="device/Unihertz/Atom_L_TEE" remote="github" revision="lineage-20.0" />
  <!-- For the Atom XL region tee add -->  
  <project name="ADeadTrousers/android_device_Unihertz_Atom_XL_TEE" path="device/Unihertz/Atom_XL_TEE" remote="github" revision="lineage-20.0" />
</manifest>
```

If you want to build with HardwareKeyMapper included add the following to the manifest-tag

```xml
  <project name="ADeadTrousers/HardwareKeyMapper" path="vendor/are/HardwareKeyMapper" remote="github" revision="master" />
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
