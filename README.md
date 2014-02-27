chu-shogi-tools
===============

Tools for rendering Chu Shogi diagrams (and other Shogi variants), and other useful programs

Prerequisites
=============

You need to install the programs bash, perl, latex, dvipng and dvisvgm. On Fedora 20 that means doing:

-sudo yum install texlive-latex-bin
-sudo yum install texlive-dvipng-bin
-sudo yum install texlive-dvisvgm-bin
-sudo yum install texlive-texconfig-bin
-sudo yum install texlive-metafont-bin
-sudo yum install 'tex(cmr10.tfm)'
-sudo yum install 'tex(colordvi.sty)'
-sudo yum install 'tex(epic.sty)'

Installation
============

1) Create an installation directory. E.g.:

mkdir ~/chu-tools

2) Copy all files from the sub-directories (bash, example, latex, perl) to the installation directory.

3) Change to the installation directory and type the command:

./forsyth2svg stampede.fsy

This should create a file stampede.svg - one of my mating problems.


