#!/bin/bash

target=`readlink .config | cut -f3 -d.`
tc_path=`grep CT_PREFIX_DIR=\" .config | cut -f2 -d\" | cut -f1-3 -d/`
build_path=".build"

if [[ "${target}" = *"-uclibc" ]]
then
    cp ${build_path}/${target}/build/build-libc-final/multilib/include/libintl.h \
        ${tc_path}/${target}/${target}/sysroot/usr/include
fi
