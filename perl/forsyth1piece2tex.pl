#!/usr/bin/perl

undef($/);

if ( $#ARGV == -1 ) {
    print STDERR "Usage: forsyth2tex.pl [-fl] forsythfile\n";
    print STDERR "Generates shogi diagrams from forsyth diagrams.\n";
    print STDERR "-f: full kanji diagrams (only for chu)\n";
    print STDERR "-l: with LaTeX wrapper for standalone files\n";
    exit();
}

$full='';
$header = 0;

foreach my $arg (@ARGV) {
    if ($arg eq '-f') {
	$full = 'full';
	shift(@ARGV);
    } elsif ( $arg eq '-l' ) {
	$header = 1;
	shift(@ARGV);
    } elsif ( $arg eq '-fl' ) {
	$header = 1;
	$full = 'full';
	shift(@ARGV);
    }
}

$_=<>;
s/\n//g;
s/([^,\/01]?[^,\/01])[01][01]/$1/g;
chomp();
@lines = split("/",$_);


%halfshopieces = ( 'k' => '\Gyoku',
		   'K' => '\OO',
		'g' => '\Kin',
		'G' => '\KIN',
		's' => '\Gin',
		'S' => '\GIN',
		'+s' => '\Narigin',
		'+S' => '\NARIGIN',
		'n' => '\Kei',
		'N' => '\KEI',
		'+n' => '\Narikei',
		'+N' => '\NARIKEI',
		'l' => '\Kyo',
		'L' => '\KYO',
		'+l' => '\Narikyo',
		'+L' => '\NARIKYO',
		'b' => '\Kaku',
		'B' => '\KAKU',
		'+b' => '\Ma',
		'+B' => '\MA',
		'r' => '\Hi',
		'R' => '\HI',
		'+r' => '\Ryu',
		'+R' => '\RYU',
		'P'  => '\FU',
		'p'  => '\Fu',
		'+P'  => '\TO',
		'+p'  => '\To',
);


%halfchupieces = ( 'k' => '\Gyoku',
		'K' => '\OO',
		'DE' => '\ZO',
		'de' => '\Zo',
		'+DE' => '\Red{\SHII}',
		'+de' => '\Red{\Shii}',
		'CP' => '\Red{\SHII}',
		'cp' => '\Red{\Shii}',
		'g' => '\Kin',
		'G' => '\KIN',
		'+g' => '\Red{\Hi}',
		'+G' => '\Red{\HI}',
		's' => '\Gin',
		'S' => '\GIN',
		'+s' => '\Red{\Ken}',
		'+S' => '\Red{\KEN}',
		'c' => '\Do',
		'C' => '\DO',
		'+c' => '\Red{\Ko}',
		'+C' => '\Red{\KO}',
		'fl' => '\Hyo',
		'FL' => '\HYO',
		'+fl' => '\Red{\Kaku}',
		'+FL' => '\Red{\KAKU}',
		'l' => '\Kyo',
		'L' => '\KYO',
		'+l' => '\Red{\Haku}',
		'+L' => '\Red{\HAKU}',
		'wh' => '\Red{\Haku}',
		'WH' => '\Red{\HAKU}',
		'rc' => '\Han',
		'RC' => '\HAN',
		'+rc' => '\Red{\Gei}',
		'+RC' => '\Red{\GEI}',
		'w' => '\Red{\Gei}',
		'W' => '\Red{\GEI}',
		'b' => '\Kaku',
		'B' => '\KAKU',
		'+b' => '\Red{\Ma}',
		'+B' => '\Red{\MA}',
		'bt' => '\Koii',
		'BT' => '\KOII',
		'+bt' => '\Red{\Roku}',
		'+BT' => '\Red{\ROKU}',
		'fs' => '\Red{\Roku}',
		'FS' => '\Red{\ROKU}',
		'ph' => '\Ho',
		'PH' => '\HO',
		'+ph' => '\Red{\Hon}',
		'+PH' => '\Red{\HON}',
		'ky' => '\Ki',
		'KY' => '\KI',
		'+ky' => '\Red{\Shi}',
		'+KY' => '\Red{\SHI}',
		'sm' => '\Ko',
		'SM' => '\KO',
		'+sm' => '\Red{\Cho}',
		'+SM' => '\Red{\CHO}',
		'fbo' => '\Red{\Cho}',
		'FBO' => '\Red{\CHO}',
		'+vm' => '\Red{\Gyu}',
		'+VM' => '\Red{\GYU}',
		'fo' => '\Red{\Gyu}',
		'FO' => '\Red{\GYU}',
		'vm' => '\Ken',
		'VM' => '\KEN',
		'r' => '\Hi',
		'R' => '\HI',
		'+r' => '\Red{\Ryu}',
		'+R' => '\Red{\RYU}',
		'dh' => '\Ma',
		'DH' => '\MA',
		'+dh' => '\Red{\Kuo}',
		'+DH' => '\Red{\KUO}',
		'hf' => '\Red{\Kuo}',
		'HF' => '\Red{\KUO}',
		'dk' => '\Ryu',
		'DK' => '\RYU',
		'+dk' => '\Red{\Ju}',
		'+DK' => '\Red{\JU}',
		'se' => '\Red{\Ju}',
		'SE' => '\Red{\JU}',
		'fk' => '\Hon',
		'FK' => '\HON',
		'ln' => '\Shi',
		'LN' => '\SHI',
		'gb' => '\Chu',
		'GB' => '\CHU',
		'+gb' => '\Red{\Suizo}',
		'+GB' => '\Red{\SUIZO}',
		'P'  => '\FU',
		'p'  => '\Fu',
		'+P'  => '\Red{\TO}',
		'+p'  => '\Red{\To}',
);


%fullchupieces = ( 'k' => '\Gyokusho',
		'K' => '\OOSHO',
		'DE' => '\SUIZO',
		'de' => '\Suizo',
		'+DE' => '\Red{\TAISHI}',
		'+de' => '\Red{\Taishi}',
		'CP' => '\Red{\TAISHI}',
		'cp' => '\Red{\Taishi}',
		'g' => '\Kinsho',
		'G' => '\KINSHO',
		'+g' => '\Red{\Hisha}',
		'+G' => '\Red{\HISHA}',
		's' => '\Ginsho',
		'S' => '\GINSHO',
		'+s' => '\Red{\Kengyo}',
		'+S' => '\Red{\KENGYO}',
		'c' => '\Dosho',
		'C' => '\DOSHO',
		'+c' => '\Red{\Ogyo}',
		'+C' => '\Red{\OGYO}',
		'fl' => '\Mohyo',
		'FL' => '\MOHYO',
		'+fl' => '\Red{\Kakugyo}',
		'+FL' => '\Red{\KAKUGYO}',
		'l' => '\Kyosha',
		'L' => '\KYOSHA',
		'+l' => '\Red{\Hakku}',
		'+L' => '\Red{\HAKKU}',
		'wh' => '\Red{\Hakku}',
		'WH' => '\Red{\HAKKU}',
		'rc' => '\Hansha',
		'RC' => '\HANSHA',
		'+rc' => '\Red{\Keigei}',
		'+RC' => '\Red{\KEIGEI}',
		'w' => '\Red{\Keigei}',
		'W' => '\Red{\KEIGEI}',
		'b' => '\Kakugyo',
		'B' => '\KAKUGYO',
		'+b' => '\Red{\Ryume}',
		'+B' => '\Red{\RYUME}',
		'bt' => '\Moko',
		'BT' => '\MOKO',
		'+bt' => '\Red{\Hiroku}',
		'+BT' => '\Red{\HIROKU}',
		'fs' => '\Red{\Hiroku}',
		'FS' => '\Red{\HIROKU}',
		'ph' => '\Hoo',
		'PH' => '\HOO',
		'+ph' => '\Red{\Hono}',
		'+PH' => '\Red{\HONO}',
		'ky' => '\Kirin',
		'KY' => '\KIRIN',
		'+ky' => '\Red{\Shishi}',
		'+KY' => '\Red{\SHISHI}',
		'sm' => '\Ogyo',
		'SM' => '\OGYO',
		'+sm' => '\Red{\Honcho}',
		'+SM' => '\Red{\HONCHO}',
		'fbo' => '\Red{\Honcho}',
		'FBO' => '\Red{\HONCHO}',
		'+vm' => '\Red{\Suigyu}',
		'+VM' => '\Red{\SUIGYU}',
		'fo' => '\Red{\Suigyu}',
		'FO' => '\Red{\SUIGYU}',
		'vm' => '\Kengyo',
		'VM' => '\KENGYO',
		'r' => '\Hisha',
		'R' => '\HISHA',
		'+r' => '\Red{\Ryuo}',
		'+R' => '\Red{\RYUO}',
		'dh' => '\Ryume',
		'DH' => '\RYUME',
		'+dh' => '\Red{\Kakuo}',
		'+DH' => '\Red{\KAKUO}',
		'hf' => '\Red{\Kakuo}',
		'HF' => '\Red{\KAKUO}',
		'dk' => '\Ryuo',
		'DK' => '\RYUO',
		'+dk' => '\Red{\Hiju}',
		'+DK' => '\Red{\HIJU}',
		'se' => '\Red{\Hiju}',
		'SE' => '\Red{\HIJU}',
		'fk' => '\Hono',
		'FK' => '\HONO',
		'ln' => '\Shishi',
		'LN' => '\SHISHI',
		'gb' => '\Chunin',
		'GB' => '\CHUNIN',
		'+gb' => '\Red{\Suizo}',
		'+GB' => '\Red{\SUIZO}',
		'P'  => '\FUGYO',
		'p'  => '\Fugyo',
		'+P'  => '\Red{\TO}',
		'+p'  => '\Red{\To}',
);

if ($header) {
    print "\\documentclass{article}\n\\usepackage{colordvi}\n\\usepackage{piece}\n\\pagestyle{empty}\\begin{document}\n";
}


$shogivar=$full.'sho';

if ($#lines==9) {
    print "\\shodiag{%\n";
    $shogivar=$full.'sho';
} elsif ($#lines==12) {
    print "\\chudiag{%\n";
    $shogivar=$full.'chu';
} elsif ($#lines==16) {
    print "\\tenjikudiag{%\n";
    $shogivar=$full.'tenjiku';
} else {
    die "$#lines lines not supported\n";
}

for(my $l =1; $l <= $#lines; $l++) {
    print "\\shogirow{".$l."}{";
    @pieces = split(",",$lines[$l]);
    foreach my $p (@pieces) {
	if ( $p =~ /^[0-9]+$/ ) {
	    my $num = int($p);
	    while($num--) { print "," }
	} else {
	    if ( $shogivar eq 'chu' ) {
		print $fullchupieces{$p}.",";
	    } elsif ( $shogivar eq 'fullchu' ) {
		print $fullchupieces{$p}.",";
	    } elsif ( $shogivar eq 'tenjiku' ) {
		print $tenjikupieces{$p}.",";
	    } elsif ( $shogivar eq 'fulltenjiku' ) {
		print $fulltenjikupieces{$p}.",";
	    } elsif ( $shogivar eq 'sho' ) {
		print $shopieces{$p}.",";
	    } else  {
		die "Unknown shogi variant $shogivar\n";
	    }
	}
    }
    print "}\n";
}

print "}\n";

if ($header) {
    print "\\end{document}\n";
}
