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

my $pi_kernel_dir = "$proj_dir/PiKernel";

my $gitAddress = "git\@github.com:eroicaleo/PiKernel.git";

chdir $proj_dir;

unless (-d $pi_kernel_dir) {
  system("git clone $gitAddress");
}

die "Can not find the kernel image!" unless -e "${kernel_dir}/arch/arm/boot/Image";
copy("${kernel_dir}/arch/arm/boot/Image", $pi_kernel_dir);

chdir $pi_kernel_dir;
system("git add Image");
system("git commit -m 'updated kernel'");
