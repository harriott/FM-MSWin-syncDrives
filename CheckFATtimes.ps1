# vim: set tw=0:

# Joseph Harriott http://momentary.eu/ Last updated: Thu 07 May 2015

# PowerShell 2.0
# Check the time differences between matching files stored locally and on a FAT32 USB stick.
# ------------------------------------------------------------------------------------------

$computer = gc env:computername
$localrd="D:\Dropbox\"
$lrdl=$localrd.length
$FAT32rd="F:\"
$locald=$localrd+"Current"

# Prepare the output file:
$outf=$FAT32rd+"CheckFATtimes-"+$computer+".txt"
"vim: tw=0:" > $outf
"" >> $outf
$now=Get-Date -format "ddd dd MMM yyyy HH:mm:ss"
"$computer"+": $now" >> $outf
"" >> $outf
"Files on FAT32 drive's time offsets:" >> $outf
"      7200 file's 2h newer than local" >> $outf
"      3600 file's 1h newer than local" >> $outf
"     -3600 file's 1h older than local" >> $outf
"     -7200 file's 2h older than local" >> $outf
"         - file ain't there" >> $outf
"" >> $outf

$localitems = gci $locald -r | where {$_.psIsContainer -eq $false} # get all the files recursively
$totalCount = $localitems.Count
$localitems | %{
    $i = $i + 1
    Write-Progress -Activity "Searching Files" -status "Searching File  $i of     $totalCount" -percentComplete ($i / $localitems.Count * 100)
	$localfn=$_.fullname.substring(11)
	$liLWT=$_.LastWriteTime
	$FAT32fn=$FAT32rd+$localfn
	if (test-path "$FAT32fn"){
		$FAT32item=gci "$FAT32fn"
		$F3LWT=$FAT32item.LastWriteTime
		$F3SAhead=(NEW-TIMESPAN -Start $liLWT -End $F3LWT).totalseconds -replace '\.\d+$'
	} else{
		$F3SAhead="-"
	}
	if ($F3SAhead -ne "0"){ "{0,10} {1,-1}" -f $F3SAhead, $FAT32fn >> $outf }
}

