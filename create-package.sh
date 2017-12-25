#!/bin/sh

umask 022

arch=`grep CT_HOST=\" .config | cut -f2 -d\" | cut -f1 -d-`
tc_path=`grep CT_PREFIX_DIR=\" .config | cut -f2 -d\"`
tc_type=`grep CT_TOOLCHAIN_TYPE=\" .config | cut -f2 -d\"`

if [ "$tc_type" != "canadian" ]
then
    echo "pacakge can be created only for canadian builds, this is ${tc_type} build"
    exit 0
fi

rm -rf tmp
mkdir tmp
mkdir tmp/CONTROL
mkdir tmp/usr

cp -r ${tc_path} tmp/usr/native-toolchain
chmod a+rX -R tmp/usr/native-toolchain
cp control.template tmp/CONTROL/control
sed -i "s/\${ARCH}/${arch}/g" tmp/CONTROL/control

opkg-build -O -o root -g root tmp .

rm -rf tmp
