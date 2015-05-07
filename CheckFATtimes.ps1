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
"Files on FAT32 drive's time offsets (-days.hours:minutes:seconds is older by that; - is not there):" >> $outf
"" >> $outf

gci $locald -r| # get all the directory contents recursively
foreach{
	$localitem=$_.fullname
	$liLWT=$_.LastWriteTime
	$liTD=NEW-TIMESPAN -Start $now -End $liLWT
	#"$liTD $localitem" >> $outf
	"{0,14} {1,-1}" -f $liTD, $localitem >> $outf
}
Write-Output $results

