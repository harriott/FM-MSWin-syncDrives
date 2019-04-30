# vim: set et fdl=2 tw=0:

# Backups only more vital data folders from  HPP  to  a smaller drive
# -------------------------------------------------------------------
# D: BX200
# E: the smaller bacukup storage

# Prepare a file to log all of the changes made:
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$ChangesLog = "E:\"+$ThisScript.TrimEnd("ps1")+"log"
"vim: nowrap tw=0:" > $ChangesLog
"" >> $ChangesLog

$FoldersArray = @(
  "Copied",
  "F+F",
  "IT_stack",
  "Now",
  "Stack",
  "Theatre0",
  "Theatre1",
  "Then0",
  "Then1",
  "toReduce",
  "Work",
  0) # dummy item

# Do the work:
foreach ($FC in $FoldersArray) {
  if ( $FC ) {
    $Glog="E:\folder-$FC"+"_fromHPP.log"
    "vim: nowrap tw=0:" > $Glog
    "" >> $Glog
    $Command = "robocopy /mir D:\Dropbox\JH\$FC E:\$FC /np /unilog+:$Glog /tee /fft"
    iex $Command # Comment this line to disable the file copying
    $Command >> $ChangesLog
    gc $Glog | select-string '    New File|    Newer|    Older|`*EXTRA File|  New Dir|`*EXTRA Dir' >> $ChangesLog
    "" >> $ChangesLog
  }
}
