#!/bin/bash

BASE_VER="andrei"
DEVICE_VER="-N915F"
VER="-BOC6-v1.0"
KERNEL_VER="$BASE_VER$DEVICE_VER$VER"

BUILD_KERNEL()
{
export LOCALVERSION=-`echo $KERNEL_VER`
export ARCH=arm
export CROSS_COMPILE=/home/andrei/edge/toolchains/arm-eabi-4.8/bin/arm-eabi-
mkdir output

make -C $(pwd) O=output VARIANT_DEFCONFIG=apq8084_sec_tblte_eur_defconfig apq8084_sec_defconfig SELINUX_DEFCONFIG=selinux_defconfig
make -C $(pwd) O=output

cp output/arch/arm/boot/Image $(pwd)/arch/arm/boot/zImage
}

# MAIN FUNCTION
rm -rf ./build.log
(
START_TIME=`date +%s`
BUILD_DATE=`date +%m-%d-%Y`
BUILD_KERNEL

END_TIME=`date +%s`

let "ELAPSED_TIME=$END_TIME-$START_TIME"
echo "Total compile time is $ELAPSED_TIME seconds"
) 2>&1	| tee -a ./build.log


