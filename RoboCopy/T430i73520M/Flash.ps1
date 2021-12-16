# vim: set fdl=2:

# backups only more vital data folders from T430i73520M to SD Card
# ----------------------------------------------------------------
# RCF  is defined in  $machine\PSProfile.ps1

# C:
# D: S32GBC10

# Prepare a file to log all of the changes made:
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$ChangesLog = "D:\"+$ThisScript.TrimEnd("ps1")+"log"
"vim: nowrap tw=0:" > $ChangesLog
"" >> $ChangesLog

$FoldersArray = @(
  "core",
  "F+F",
  "Now",
  "Technos",
  "Theatre0",
  "Theatre1",
  "Then0",
  "Then1",
  "T91-default-release",
  "Work",
  0) # dummy item

# Do the work:
foreach ($FC in $FoldersArray) {
  if ( $FC ) {
    $Glog="D:\dir-$FC"+"_fromHPP.log"
    "vim: nowrap tw=0:" > $Glog
    "" >> $Glog
    $Command = "robocopy /mir C:\Users\troin\Dropbox\JH\$FC D:\$FC /np /unilog+:$Glog /tee /fft"
    iex $Command # Comment this line to disable the file copying
    $Command >> $ChangesLog
    gc $Glog | select-string '    New File|    Newer|    Older|`*EXTRA File|  New Dir|`*EXTRA Dir' >> $ChangesLog
    "" >> $ChangesLog
  }
}
