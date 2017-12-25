#!/bin/sh

umask 022

create_canadian()
{
    cp -r ${tc_path} tmp/usr/native-toolchain
    chmod a+rX -R tmp/usr/native-toolchain
    cp canadian-control.template tmp/CONTROL/control
    sed -i "s/\${ARCH}/${arch}/g" tmp/CONTROL/control
}


create_cross()
{
    CT_TARGET="${arch}-${vendor}-${kernel}-${lib}"
    path=`echo "${tc_path}" | sed "s/\\${CT_TARGET}/${CT_TARGET}/g"`
    mkdir tmp/usr/cross-toolchain
    cp -r ${path} tmp/usr/cross-toolchain
    cp cross-control.template tmp/CONTROL/control
    sed -i "s/\${TARGET}/${CT_TARGET}/" tmp/CONTROL/control
}


arch=`readlink .config | cut -f2 -d-`
lib="gnu"
vendor=`grep CT_TARGET_VENDOR=\" .config | cut -f2 -d\"`
kernel=`grep CT_KERNEL=\" .config | cut -f2 -d\"`
tc_path=`grep CT_PREFIX_DIR=\" .config | cut -f2 -d\"`
tc_type=`grep CT_TOOLCHAIN_TYPE=\" .config | cut -f2 -d\"`


rm -rf tmp
mkdir tmp
mkdir tmp/CONTROL
mkdir tmp/usr

if [ "${tc_type}" = "canadian" ]
then
    create_canadian
else
    create_cross
fi

opkg-build -O -o root -g root tmp .
#rm -rf tmp
