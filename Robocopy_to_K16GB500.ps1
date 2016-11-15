# vim: set et tw=0:

# Backups from  HPP  to  K16GB500
# --------------------------------------
# E: SDSSDA240G
# G: K16GB500

# Prepare a file to log all of the changes made:
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$ChangesLog = "G:\"+$ThisScript.TrimEnd("ps1")+"log"
"vim: nowrap tw=0:" > $ChangesLog
"" >> $ChangesLog

$FoldersArray = @("Copied", "Now", "Then0", "Then1", "Work")
#$FoldersArray = @("Now")

# Do the work:
foreach ($FC in $FoldersArray) {
  $Glog="G:\k-$FC"+"_fromHPP.log"
  "vim: nowrap tw=0:" > $Glog
  "" >> $Glog
  $Command = "robocopy /mir E:\Dropbox\JH\k-$FC G:\k-$FC /np /unilog+:$Glog /tee /fft"
  iex $Command # Comment this line to disable the file copying
  $Command >> $ChangesLog
  gc $Glog | select-string '    New File|    Newer|    Older|`*EXTRA File|  New Dir|`*EXTRA Dir' >> $ChangesLog
  "" >> $ChangesLog
}

