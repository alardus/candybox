package_builder
===============

- candybox-'package.version' - contain part of original 'deploy' configs and scripts, which we must be possible to upgrade by releasing new package.

- xl2tpd-modules-'kernel.version' - contain xl2tp_ modules builded for current upstream kernel version, needed for running xl2tpd daemon builded with kernel support

- xl2tpd-kernel_'xl2tpd.version'+dfsg-'package.version'_'arch' - contain version of xl2tpd daemon builded with kernel support and some other patches. This package used to avoid conflict with original 'xl2tpd' in Raspbian repository.

- repo-update.sh - build packages 'candybox', 'xl2tpd-kernel' and create Packages.gz for those packages. After that you may copy folder 'ubuntu' content to repository.