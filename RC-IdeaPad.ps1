# vim: set et fdl=2 tw=0:

# Pulls useful data that won't fit in Lenovo IdeaPad 120s 81A4 C:
# ---------------------------------------------------------------
# D: L32GBC10
# E: SM3

# Prepare a file to log all of the changes made:
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$Changes = "D:\"+$ThisScript.TrimEnd("ps1")
$ChangesLog = $Changes+"log"
$Changes = $Changes+"tmp"
"vim: fdm=expr ft=RClog:" > $ChangesLog
"" >> $ChangesLog

$FoldersArray = @(
  "Sync0\Dr-JH-Cafezoide",
  "Sync0\Dr-JH-CforWork",
  "Sync0\Dr-JH-Copied",
  "Sync0\Dr-JH-core",
  "Sync0\Dr-JH-F+F",
  "Sync0\Dr-JH-JCD-imagey-e3",
  "Sync0\Dr-JH-Now",
  "Sync0\Dr-JH-Technos",
  "Sync0\Dr-JH-Thechnos",
  "Sync0\Dr-JH-Theatre0",
  "Sync0\Dr-JH-Theatre1",
  "Sync0\Dr-JH-Then0",
  "Sync0\Dr-JH-Then1",
  "Sync0\Dr-JH-toReduce",
  "Sync0\Dr-JH-TP.default-release",
  "Sync0\Dr-JH-Work",
  "Sync1\Dr-JH-Stack",
  "Sync1\ThunderbirdProfiles",
  0) # dummy item

# Do the work:
foreach ($FE in $FoldersArray) {
  if ( $FE ) {
    $FD = $FE -replace '\\','-'
    write-host $FD -foreground "magenta" -backgroundcolor "darkmagenta"
    $folderLog = "D:\dir-$FD"+"_fromSM3.log"
    # $simulate = ' /l'
    $Command = "robocopy /mir E:\$FE D:\$FD /np /unilog+:$folderLog /tee /fft"+$simulate
    # now (try) the changes
      "vim: nowrap tw=0:" > $folderLog; "" >> $folderLog; iex $Command
    "# $FD" >> $ChangesLog
    "    $Command" >> $ChangesLog
    $Changes = Get-Content $folderLog | select-string '    New File|    Newer|    Older|`*EXTRA File|  New Dir|`*EXTRA Dir'
    if ( $Changes ) {
      write-host "there were changes" -foreground "cyan" -backgroundcolor "darkmagenta"
      ""
      "" >> $ChangesLog
      "Changes:" >> $ChangesLog
      $Changes >> $ChangesLog }
    "" >> $ChangesLog
  }
}

gvim -c "silent! /^Changes:" $ChangesLog

