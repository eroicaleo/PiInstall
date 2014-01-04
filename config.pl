#!/usr/bin/env perl

use warnings;
use strict;

use Cwd;
use File::Basename;
use File::Copy;

my $script_dir = getcwd;
print "script dir is: $script_dir\n";
my $proj_dir = dirname($script_dir);
print "project dir is: $proj_dir\n";
my $kernel_dir = "${proj_dir}/kernel";
print "kernel source dir is: $kernel_dir\n";
my $tool_dir = "${proj_dir}/tools";
print "toolchain dir is: $tool_dir\n";

die "Can not find kernel source dir!" unless -d $kernel_dir;

chdir $kernel_dir;

my $CCPREFIX = "${tool_dir}/arm-bcm2708/arm-bcm2708-linux-gnueabi/bin/arm-bcm2708-linux-gnueabi-";
print "CCPREFIX = $CCPREFIX\n";

unless (-f ".config") {
  print "There is no .config in the kernel source directory, will copy brcm default config: arch/arm/configs/bcmrpi_defconfig!\n";
  copy("arch/arm/configs/bcmrpi_defconfig", ".config");
}

my $cmd = "make ARCH=arm CROSS_COMPILE=${CCPREFIX} menuconfig";

print "
If you want to enable KDB/KGDB, please enable the following options: 
1. CONFIG_MAGIC_SYSRQ (hotkey: 'K'*2 + 'a'*1)
2. CONFIG_KGDB (hotkey: 'K'*2 + PgDn*2 + 'K'*1)
2.1 CONFIG_KGDB_SERIAL_CONSOLE
2.2 CONFIG_KGDB_KDB
2.3 CONFIG_KDB_KEYBOARD
3. CONFIG_DEBUG_INFO (hotkey: 'K'*2 + PgDn*1 + 'C'*1), this will in turn turn on the ARM_UNWIND
";

print "Will do:\n$cmd\nPress any key to continue...";

my $answer = <STDIN>;
system($cmd);

