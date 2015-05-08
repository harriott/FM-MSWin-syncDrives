# vim: set tw=0:

# Joseph Harriott http://momentary.eu/ Last updated: Thu 07 May 2015

# PowerShell 2.0
# Check the time differences between matching files stored locally and on a FAT32 USB stick.
# ------------------------------------------------------------------------------------------

$computer = gc env:computername
$localrd="D:\Dropbox\"
$FAT32rd="F:\"
$locald=$localrd+"Current\Copied\Nederland\Rotterdam*"

# Prepare the output file:
#$outf=$FAT32rd+"CheckFATtimes-"+$computer+".txt"
$outf="CheckFATtimes-"+$computer+".txt"
"vim: tw=0:" > $outf
"" >> $outf
$now=Get-Date -format "ddd dd MMM yyyy HH:mm:ss"
"$computer"+": $now" >> $outf
"" >> $outf
"Files on FAT32 drive's time offsets:" >> $outf
" -days.hours:minutes:seconds => is older by that" >> $outf
"                           - => is not there" >> $outf
"      3600   file's 1h newer than local" >> $outf
"      7200   file's 2h newer than local" >> $outf
"     -3600   file's 1h older than local" >> $outf
"     -7200   file's 2h older than local" >> $outf
"         -   file ain't there" >> $outf
"" >> $outf

gci $locald -r| # get all the directory contents recursively
foreach{
	$localitem=$_.fullname
	$liLWT=$_.LastWriteTime
	$liTAhead=(NEW-TIMESPAN -Start $now -End $liLWT)
	$liSAhead=(NEW-TIMESPAN -Start $now -End $liLWT).totalseconds -replace '\.\d+$'
	"{0,17} {1,-1}" -f $liTAhead, $localitem >> $outf
	"{0,17} {1,-1}" -f $liSAhead, $localitem >> $outf
}

