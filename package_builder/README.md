package_builder
===============

- candybox-'kernel.version'-'package.version' - package contain part of original 'deploy' configs and scripts, which we must be possible to upgrade by releasing new package.

- xl2tpd-kernel_'xl2tpd.version'+dfsg-'package.version'_'arch' - we need avoid conflict with package 'xl2tpd' in Raspbian repository, so that is simple wrapper for renaming package from 'xl2tpd' to 'xl2tpd-kernel'.

- repo-update.sh - build packages 'candybox', 'xl2tpd-kernel' and create Packages.gz for those packages. After that you may copy folder 'ubuntu' content to repository.