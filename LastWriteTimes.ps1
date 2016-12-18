# Joseph Harriott  http://momentary.eu/  Wed 16 Nov 2016

# Check the time differences between matching files stored locally and on USB drives.
# -----------------------------------------------------------------------------------
# I'm guessing that  NTFS-3G  sometimes messes up the other two timestamps with the result that non-tangible differences get propagated when sync'ing between  Win10  &  GNU/Linux  systems.  I'm only really interested in  LastWriteTime.

# E: MQ01ABF050
$SyncDir="F:\Sync" # F: Samsung M3
# G: K16GB500
$FoldersArray = @(
    # first element of each row allows for that row to be switched off, by setting to 0
    #   gVim  Tabularize/,/l0l0l0  then view in a larger window
    #
    (0,0                                 ,"$SyncDir"                         ,"G:"         ), # for folder-identifying, later
    (0,"E:\Dropbox\Copied"               ,"$SyncDir\Dr-Copied"               ,0            ),
    (0,"E:\Dropbox\Copied-Music-toPlay"  ,"$SyncDir\Dr-Copied-Music-toPlay"  ,0            ),
    (0,"E:\Dropbox\Copied-OutThere-Audio","$SyncDir\Dr-Copied-OutThere-Audio",0            ),
    (0,"E:\Dropbox\Copied-UK-Audio"      ,"$SyncDir\Dr-Copied-UK-Audio"      ,0            ),
    (0,"E:\Dropbox\JH\d-F+F"             ,"$SyncDir\Dr-JH-d-F+F"             ,0            ),
    (0,"E:\Dropbox\JH\d-Stack"           ,"$SyncDir\Dr-JH-d-Stack"           ,0            ),
    (0,"E:\Dropbox\JH\d-Theatre"         ,"$SyncDir\Dr-JH-d-Theatre"         ,0            ),
    (0,"E:\Dropbox\JH\k-Copied"          ,"$SyncDir\Dr-JH-k-Copied"          ,"G:\k-Copied"),
    (0,"E:\Dropbox\JH\k-Now"             ,"$SyncDir\Dr-JH-k-Now"             ,"G:\k-Now"   ),
    (0,"E:\Dropbox\JH\k-Then0"           ,"$SyncDir\Dr-JH-k-Then0"           ,"G:\k-Then0" ),
    (0,"E:\Dropbox\JH\k-Then1"           ,"$SyncDir\Dr-JH-k-Then1"           ,"G:\k-Then1" ),
    (0,"E:\Dropbox\JH\k-Work"            ,"$SyncDir\Dr-JH-k-Work"            ,"G:\k-Work"  ),
    (0,"E:\Dropbox\Photos"               ,"$SyncDir\Dr-Photos"               ,0            ),
    (1,"E:\IT-Copied"                    ,"$SyncDir\IT-Copied"               ,0            ),
    (0,"E:\IT-DebianBased-Copied"        ,"$SyncDir\IT-DebianBased-Copied"   ,0            ),
    (0,"E:\More"                         ,"$SyncDir\More"                    ,0            ),
    (0,0                                 ,0                                  ,0            ) # dummy row, all 0
    )

# Prepare the output files:
$computer = gc env:computername # a tag
$OutF="LastWriteTimes-$computer.txt"
$EOutF="E:\$OutF" # local template
$USBParents=$FoldersArray[0]
$USBOutF=0,0,"$($USBParents[2])\$OutF","$($USBParents[3])\$OutF"
"Preparing  $($USBOutF[2])  &  $($USBOutF[3])"
"vim: set nowrap tw=0:" > $EOutF
"" >> $EOutF
$startts=Get-Date -format "ddd dd MMM yyyy HH:mm:ss"
"$computer"+": $startts" >> $EOutF
"" >> $EOutF
"Files on USB drive's time offsets (rounded to whole seconds):" >> $EOutF
"      7200 file's 2h newer than local" >> $EOutF
"      3600 file's 1h newer than local" >> $EOutF
"     -3600 file's 1h older than local" >> $EOutF
"     -7200 file's 2h older than local" >> $EOutF
"         - file ain't there" >> $EOutF
"" >> $EOutF
$USBParent=0,0,0,0 # begin by assuming that the USB parent folders aren't there
foreach ($i in 2,3) {
    if ( Test-Path $USBParents[$i] ) { # the folder's there, so proceed
        $USBParent[$i]=1
        cpi $EOutF $USBOutF[$i]
    } else { "$($USBParents[$i])  ain't there..." }
}
ri $EOutF # removes the local template

# Go ahead, if at least one of the USB drives is there:
if ( !($USBParent[2]) -or $USBParents[3] ) {
    foreach ($FolderControl in $FoldersArray) {
        # check that this folder is wanted:
        if ( $FolderControl[0] ) {
            # Go ahead, if the local folder exists:
            if ( Test-Path $FolderControl[1] ) {
                $localParentlength=$FolderControl[1].length
                # Get all the local files recursively:
                echo "Getting  $($FolderControl[1])  child-items"
                $localitems = gci $FolderControl[1] -r | where {$_.psIsContainer -eq $false}
                # Compare with USB files:
                foreach ($i in 2,3) {
                    if ($USBParent[$i] ) { # checking that the USB drive's there
                        if ( Test-Path $FolderControl[$i] ) { # and the USB folder exists
                            $tsc = Get-Date
                            "- comparing against  $($FolderControl[$i])"
                            $totalCount = $localitems.Count
                            $j = 0
                            $localitems | %{
                                $j = $j + 1
                                Write-Progress -Activity "Searching Files" -status "Searching File  $j of     $totalCount" -percentComplete ($j / $localitems.Count * 100)
                                $localFile=$_.fullname.substring($localParentlength)
                                $liLWT=$_.LastWriteTime
                                $USBFile=$FolderControl[$i]+$localFile
                                if (Test-Path -literalPath "$USBFile"){
                                    $USBitem=gci -literalPath "$USBFile"
                                    $USBLWT=$USBitem.LastWriteTime
                                    $USBAhead=[math]::Round((NEW-TIMESPAN -Start $liLWT -End $USBLWT).totalseconds)
                                } else{
                                    $USBAhead="-"
                                }
                                if ($USBAhead -ne "0"){ "{0,10} {1,-1}" -f $USBAhead, $USBFile >> $USBOutF[$i] }
                            }
                            "" >> $USBOutF[$i]
                            $tec = (new-timespan -start $tsc -end (Get-Date)).totalseconds
                            echo "- took $tec seconds" >> $USBOutF[$i]
                            "" >> $USBOutF[$i]
                        }
                    }
                }
            } else { "$localFolder  ain't there..." }
        }
    }
}

