# Joseph Harriott  http://momentary.eu/  Wed 20 Jun 2018

# Backup my Share files.
# PS> D:\Dropbox\JH\IT_stack\onGitHub\SyncPortableDrives\RobocopySM3_Share.ps1
# ----------------------------------------------------------------------

# Drives:
# F: SM3
$backupFolder = "F:\RcBuShare"
$FoldersArray = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  #   gVim  Tabularize/,/l0l0l0  then view in a larger window
  #
  (1,"F:\Share\AV-Stack"                 ,"$backupFolder\AV-Stack")                 ,
  (1,"F:\Share\Dr-CAT-Buddhism"          ,"$backupFolder\Dr-CAT-Buddhism")          ,
  (1,"F:\Share\Dr-CAT-Buddhism-Theravada","$backupFolder\Dr-CAT-Buddhism-Theravada"),
  (1,"F:\Share\Dr-CAT-OutThere"          ,"$backupFolder\Dr-CAT-OutThere")          ,
  (1,"F:\Share\Dr-CAT-OutThere-UK"       ,"$backupFolder\Dr-CAT-OutThere-UK")       ,
  (1,"F:\Share\IT-Copied"                ,"$backupFolder\IT-Copied")                ,
  (1,"F:\Share\IT-DebianBased-Copied"    ,"$backupFolder\IT-DebianBased-Copied")    ,
  (1,"F:\Share\More"                     ,"$backupFolder\More")                     ,
  (0,0                                   ,0) # dummy row                            ,to close
  )

# Dialogue with myself:
""
"Joseph, this Powershell script will use Robocopy to mirror your personal folders."
[System.Console]::BackgroundColor = 'DarkCyan'
[System.Console]::ForegroundColor = 'White'
""
$reply = Read-Host "Do you want to backup (B) F:\Share\ (or simulate (b))? "
[System.Console]::ResetColor()
""

$simulate = ""
if ($reply -ceq "B") {
  "Okay, running backups to $backupFolder`n"
  $reply = "b"
  }
elseif ($reply -ceq "b") {
  "Okay, running simulation for `"mirror to $backupFolder`"`n"
  $simulate = " /l"
  } else { exit }

# Prepare variables for log file:
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$ChangesLog = "F:\Share\"+$ThisScript.TrimEnd("ps1")+"log"

# Do the work:
$Progress = ""
. $PSScriptRoot\RoboWork.ps1

