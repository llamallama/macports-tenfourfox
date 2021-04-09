# macports-tenfourfox

## tl;dr

Run this to get a MacPorts environment that can build MacPorts on OS X Tiger.

Run `./bootstrap_tenfourfox.sh`

This is intended for OS X Tiger only. Now that Dr. Cameron Kaiser will no longer be providing precompiled builds of TenFourFox, it's up to us to [build it for ourselves](https://github.com/classilla/tenfourfox/wiki/HowToBuildFPR).
Setting up the requiements to do so is a long, arduous, and error prone process. As such, I've created this script.

It:

1. Completely removes your current MacPorts installation
1. Downloads a working one from http://tenfourports.pipetogrep.org/opt.tar.gz which is backed by an S3 bucket on my AWS account
1. Uncompresses it into /opt

It is a snapshot of my current working MacPorts tree. This script will replace your entire existing MacPorts setup so be sure you're either starting scratch or have a backup. It is only intended for those who don't already have a functional MacPorts environment.

Please note, this does not build TenFourFox for you, only the MacPorts environment needed to build it for your self. Please also note that it does not include git gdb7. After running this, you can skip to https://github.com/classilla/tenfourfox/wiki/HowToBuildFPR#building-the-browser. Since you won't have git, you'll have to download source code as a zip file from https://github.com/classilla/tenfourfox/archive/refs/heads/master.zip

## Usage

Run `./bootstrap_tenfourfox.sh`
