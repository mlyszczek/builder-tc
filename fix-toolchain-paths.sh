#!/bin/bash

script_path=`realpath ${0}`
build_path="`dirname ${script_path}`/.build"
tc_path=`grep CT_PREFIX_DIR=\" .config | cut -f2 -d\"`
tc_host=`grep CT_HOST=\" .config | cut -f2 -d\"`
tc_type=`grep CT_TOOLCHAIN_TYPE=\" .config | cut -f2 -d\"`
tool_path="${build_path}/tools"
buildtools_path="${build_path}/HOST-${tc_host}/${tc_host}/buildtools"

if [ "$tc_type" != "canadian" ]
then
    echo "only canadian builds need path fixing, this is ${tc_type} build"
    exit 0
fi

tc_path_escaped=`echo "${tc_path}" | sed 's@\/@\\\/@g'`
tool_path_escaped=`echo "${tool_path}" | sed 's@\/@\\\/@g'`
buildtools_path_escaped=`echo "${buildtools_path}" | sed 's@\/@\\\/@g'`

sed -i "s@${tool_path_escaped}@@g" ${tc_path}/bin/libtool
sed -i "s@${tool_path_escaped}@@g" ${tc_path}/bin/libtoolize
sed -i "s@${buildtools_path_escaped}@${tc_path_escaped}@g" ${tc_path}/bin/libtool
sed -i "s@${buildtools_path_escaped}@${tc_path_escaped}@g" ${tc_path}/bin/autom4te
sed -i "s@${buildtools_path_escaped}@${tc_path_escaped}@g" ${tc_path}/bin/autoupdate

tools="addr2line ar as c++ c++filt cc cpp \
    elfedit g++ gcc gcc-6.4.0 gcc-ar gcc-nm gcc-ranlib \
    gcov gcov-dump gcov-tool gdb gprof ld ld.bfd ldd nm \
    objcopy objdump populate ranlib readelf size strings strip"

for t in $tools
do
    ln -fs "${tc_path}/bin/${tc_host}-${t}" ${tc_path}/bin/${t}
done
