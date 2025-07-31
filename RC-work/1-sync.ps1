# vim: set et fdl=2:

# $onGH/FM-MSWin-syncDrives/RC-work/1-sync.ps1

# Joseph Harriott  http://momentary.eu/  Sun 08 Jul 2018

# sourced by files in  $onGH/FM-MSWin-syncDrives/RC-machines

$reply = Read-Host "Do you want to backup (b), or mirror TO (T) portable drives (or simulate (t)),  or mirror FROM (F) (or simulate (f))? "
[System.Console]::ResetColor()
""

$simulate = ""
if ($reply -ceq "b") {"Okay, running backups to $backupFolder`n"}
elseif ($reply -ceq "T") {
  [System.Console]::BackgroundColor = 'Blue'
  [System.Console]::ForegroundColor = 'White'
  ""
  $replyCheck = Read-Host "You want to go ahead and mirror changes TO external drives? "
  [System.Console]::ResetColor()
  ""
  if ( $replyCheck -ne "y" ) {exit}
} elseif ($reply -ceq "t") {
    "Okay, running simulation for `"mirror to external drives`"`n"
    $simulate = " /l"
} elseif ($reply -ceq "F") {
    [System.Console]::BackgroundColor = 'Yellow'
    [System.Console]::ForegroundColor = 'DarkBlue'
    ""
    $replyCheck = Read-Host "You want to go ahead and mirror changes FROM external drives? "
    [System.Console]::ResetColor()
    ""
  if ( $replyCheck -ne "y" ) {exit}
} elseif ($reply -ceq "f") {
    "Okay, running simulation for `"mirror from external drives`"`n"
    $simulate = " /l"
} else { exit }

# Prepare variables for log file:
$ChangesLog = "$Drpbx\"+$ThisScript.TrimEnd("ps1")+"log"

# Do the work:
$Progress = "/NP"
. $onGH/FM-MSWin-syncDrives/RC-work/2-work.ps1

