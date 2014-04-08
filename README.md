chu-shogi-tools
===============

Tools for rendering Chu Shogi diagrams (and other Shogi variants), and other useful programs

Prerequisites
=============

You need to install the programs bash, perl, latex, dvipng and dvisvgm. On Fedora 20 that means doing:

- sudo yum install texlive-latex-bin
- sudo yum install texlive-dvipng-bin
- sudo yum install texlive-dvisvgm-bin
- sudo yum install texlive-texconfig-bin
- sudo yum install texlive-metafont-bin
- sudo yum install texlive-mfware-bin
- sudo yum install 'tex(cmr10.tfm)'
- sudo yum install 'tex(colordvi.sty)'
- sudo yum install 'tex(epic.sty)'

For the tools written in Eiffel, you should also install EiffelStudio from Eiffel Software.

Installation
============

1) Create an installation directory. E.g.:

mkdir ~/chu-tools

2) Copy all files from the sub-directories (bash, example, latex, perl) to the installation directory.

3) Change to the eiffel directory: cd eiffel

4) cd fen2fsy

5) ec -config fen2fsy.ecf

6) cd EIFGENs/fen2fsy/F_code

7) finish_freezing

8) cp fen2fsy ~/chu-tools

9) cd ../../..

10) rm -rf EIFGENs

11) cp fen2fsy start.fen ~/chu-tools

12) Change to the installation directory (cd ~/chu-tools) and type the command:

./forsyth2svg stampede.fsy

This should create a file stampede.svg - one of my mating problems.

13) Type the commands:

./fen2fsy start.fen start.fsy
./forsyth2png start.fsy

This should create a file start1.png - the start position obtained by doing File -> Save Position from the xboard menu


