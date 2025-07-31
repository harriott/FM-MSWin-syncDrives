# vim: set et fdl=3 tw=0:

# $onGH/FM-MSWin-syncDrives/RC-machines/IdeaPad.ps1

# Pulls useful data that won't fit in Lenovo IdeaPad 120s 81A4 C:
# ---------------------------------------------------------------
# D: L32GBC10
# E: SM3

# Prepare a file to log all of the changes made:
$ThisScript = $MyInvocation.MyCommand.Path
$ChangesLog = "D:\Sync0Dr\Changes.log"
"vim: ft=RClog:" > $ChangesLog
"" >> $ChangesLog
$MyInvocation.MyCommand.Path >> $ChangesLog
"" >> $ChangesLog

$FoldersArray = @(
  "Cafezoide",
  "CforWork",
  "Copied",
  "core",
  "F+F",
  "JCD-imagey-e3",
  "Now",
  "Stack",
  "Technos",
  "Theatre0",
  "Theatre1",
  "Then0",
  "Then1",
  "toReduce",
  "TP.default-release",
  "Work",
  0) # dummy item

# Do the work:
foreach ($SF in $FoldersArray) {
  if ( $SF ) {
    write-host $SF -foreground "magenta" -backgroundcolor "darkmagenta"
    $folderLog = "D:\Sync0Dr\fromSM3"+"-$SF"+".log"
    $simulate = ' /l'
    $Command = "robocopy /mir E:\Sync0Dr\JH-$SF D:\Sync0Dr\$SF /np /unilog+:$folderLog /tee /fft"+$simulate
    # now (try) the changes
      "vim: nowrap tw=0:" > $folderLog
      "" >> $folderLog
      $Command
      iex $Command
    "# $SF" >> $ChangesLog
    "    $Command" >> $ChangesLog
    $Changes = Get-Content $folderLog | select-string '    New File|    Newer|    Older|`*EXTRA File|  New Dir|`*EXTRA Dir'
    if ( $Changes ) {
      write-host "there were changes" -foreground "cyan" -backgroundcolor "darkmagenta"
      ""
      "" >> $ChangesLog
      "Changes:" >> $ChangesLog
      $Changes >> $ChangesLog }
    "" >> $ChangesLog
    $Errors = Get-Content $folderLog | select-string ' ERROR .*? Accessing Source Directory'
    if ( $Errors ) {
      write-host $Errors -foreground "magenta" -backgroundcolor "darkmagenta"
      "- directory error somewhere..."
      exit }
  }
}

gvim -c "silent! /^Changes:" $ChangesLog

