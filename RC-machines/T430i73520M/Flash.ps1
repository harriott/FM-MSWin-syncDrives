
# vim: set fdl=3:

# Thu 28 Jul 2022

# $onGH/FM-MSWin-syncDrives/RC-machines/T430i73520M/Flash.ps1

# backups only more vital data folders from T430i73520M to SD Card
# ----------------------------------------------------------------

# C:
# E: SDU64GB  (D: isn't always available)

# Prepare a file to log all of the changes made:
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$TSBaseName = $ThisScript.TrimEnd(".ps1")
if ( test-path 'E:\' ) {
  $ChangesLog = "E:\"+$TSBaseName+"_ps1.log"
  "vim: ft=RClog nowrap tw=0:" > $ChangesLog
  "" >> $ChangesLog

  $FoldersArray = @(
    "Cafezoide",
    "copied",
    "core",
    "F+F",
    "now",
    "technos",
    "Theatre0",
    "T91-default-release",
    "work",
    0) # dummy item

# Do the work:
  foreach ($FC in $FoldersArray) {
    if ( $FC ) {
      $Glog="E:\$TSBaseName-$FC"+".log"
      "vim: nowrap tw=0:" > $Glog
      "" >> $Glog
      $Command = "robocopy /mir C:\Users\troin\Dropbox\JH\$FC E:\$FC /np /unilog+:$Glog /tee /fft"
      iex $Command # Comment this line to disable the file copying
      "# $Glog" >> $ChangesLog
      $Command >> $ChangesLog
      gc $Glog | select-string '    New File|    Newer|    Older|`*EXTRA File|  New Dir|`*EXTRA Dir' >> $ChangesLog
      "" >> $ChangesLog
    }
  }
  gvim $ChangesLog
} else { "E:\ should be SDU64GB" }

