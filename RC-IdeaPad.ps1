# vim: set et fdl=2 tw=0:

# Pulls useful data that won't fit in Lenovo IdeaPad 120s 81A4 C:
# ---------------------------------------------------------------
# D: L32GBC10
# E: SM3

# Prepare a file to log all of the changes made:
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$ChangesLog = "D:\"+$ThisScript.TrimEnd("ps1")+"log"
"vim: nowrap tw=0:" > $ChangesLog
"" >> $ChangesLog

$FoldersArray = @(
  "Sync0\Dr-JH-Cafezoide",
  "Sync0\Dr-JH-CforWork",
  "Sync0\Dr-JH-Copied",
  "Sync0\Dr-JH-F+F",
  "Sync0\Dr-JH-IT_stack",
  "Sync0\Dr-JH-JCD-imagey-e3",
  "Sync0\Dr-JH-Now",
  "Sync0\Dr-JH-Theatre0",
  "Sync0\Dr-JH-Theatre1",
  "Sync0\Dr-JH-Then0",
  "Sync0\Dr-JH-Then1",
  "Sync0\Dr-JH-toReduce",
  "Sync0\Dr-JH-Work",
  "Sync1\Dr-JH-Stack",
  0) # dummy item

# Do the work:
foreach ($FE in $FoldersArray) {
  if ( $FE ) {
    $FD = $FE -replace '\\','-'
    echo $FD
    $Glog="D:\dir-$FD"+"_fromSM3.log"
    "vim: nowrap tw=0:" > $Glog
    "" >> $Glog
    $Command = "robocopy /mir E:\$FE D:\$FD /np /unilog+:$Glog /tee /fft"
    iex $Command # Comment this line to disable the file copying
    $Command >> $ChangesLog
    gc $Glog | select-string '    New File|    Newer|    Older|`*EXTRA File|  New Dir|`*EXTRA Dir' >> $ChangesLog
    "" >> $ChangesLog
  }
}
