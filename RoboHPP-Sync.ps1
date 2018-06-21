# Joseph Harriott  http://momentary.eu/  Wed 20 Jun 2018

# Sync/backup my personal files to/from HPP:11-n012na
# PS> D:\Dropbox\JH\IT_stack\onGitHub\SyncPortableDrives\RobocopyHPP.ps1
# ----------------------------------------------------------------------

# Drives:
# D: BX200
# F: SM3
$backupFolder = "F:\SyncRcBu"
$FoldersArray = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  #   gVim  Tabularize/,/l0l0l0  then view in a larger window
  #
  (1,"D:\Dropbox\CAM-fromSharon" ,"$backupFolder\Dr-CAM-fromSharon"    ,"F:\Sync\Dr-CAM-fromSharon")    ,
  (1,"D:\Dropbox\CAMusic"        ,"$backupFolder\Dr-CAMusic"           ,"F:\Sync\Dr-CAMusic")           ,
  (1,"D:\Dropbox\Copied-OutThere","$backupFolder\Dr-Copied-OutThere"   ,"F:\Sync\Dr-Copied-OutThere")   ,
  (1,"D:\Dropbox\JH\Copied"      ,"$backupFolder\Dr-JH-Copied"         ,"F:\Sync\Dr-JH-Copied")         ,
  (1,"D:\Dropbox\JH\F+F"         ,"$backupFolder\Dr-JH-F+F"            ,"F:\Sync\Dr-JH-F+F")            ,
  (1,"D:\Dropbox\JH\IT_stack"    ,"$backupFolder\Dr-JH-IT_stack"       ,"F:\Sync\Dr-JH-IT_stack")       ,
  (1,"D:\Dropbox\JH\Now"         ,"$backupFolder\Dr-JH-Now"            ,"F:\Sync\Dr-JH-Now")            ,
  (1,"D:\Dropbox\JH\Stack"       ,"$backupFolder\Dr-JH-Stack"          ,"F:\Sync\Dr-JH-Stack")          ,
  (1,"D:\Dropbox\JH\Theatre0"    ,"$backupFolder\Dr-JH-Theatre0"       ,"F:\Sync\Dr-JH-Theatre0")       ,
  (1,"D:\Dropbox\JH\Theatre1"    ,"$backupFolder\Dr-JH-Theatre1"       ,"F:\Sync\Dr-JH-Theatre1")       ,
  (1,"D:\Dropbox\JH\Then0"       ,"$backupFolder\Dr-JH-Then0"          ,"F:\Sync\Dr-JH-Then0")          ,
  (1,"D:\Dropbox\JH\Then1"       ,"$backupFolder\Dr-JH-Then1"          ,"F:\Sync\Dr-JH-Then1")          ,
  (1,"D:\Dropbox\JH\toReduce"    ,"$backupFolder\Dr-JH-toReduce"       ,"F:\Sync\Dr-JH-toReduce")       ,
  (1,"D:\Dropbox\JH\Work"        ,"$backupFolder\Dr-JH-Work"           ,"F:\Sync\Dr-JH-Work")           ,
  (1,"D:\Dropbox\Photos"         ,"$backupFolder\Dr-Photos"            ,"F:\Sync\Dr-Photos")            ,
  (0,0                           ,0                                    ,0) # dummy row
  )

# Dialogue with myself:
""
"Joseph, this Powershell script will use Robocopy to mirror your personal folders."
[System.Console]::BackgroundColor = 'DarkCyan'
[System.Console]::ForegroundColor = 'White'
""
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
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$ChangesLog = "D:\Dropbox\"+$ThisScript.TrimEnd("ps1")+"log"

# Do the work:
$Progress = "/NP"
. $PSScriptRoot\RoboWork.ps1

