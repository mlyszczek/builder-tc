unexport LD_LIBRARY_PATH

all:
	./ct-ng build
	./fix-toolchain-paths.sh
	./fix-missing-libintl-in-uclibc.sh
	./create-package.sh

nconfig:
	./ct-ng nconfig
