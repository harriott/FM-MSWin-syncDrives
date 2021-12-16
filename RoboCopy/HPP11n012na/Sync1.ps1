# Joseph Harriott  http://momentary.eu/  Mon 25 Jun 2018

# Sync/backup my personal files to/from HPP:11-n012na
# PS> D:\Dropbox\JH\IT_stack\onGitHub\SyncPortableDrives\RobocopyHPP.ps1
# ----------------------------------------------------------------------

# Drives:
# D: BX200
# F: SM3
$backupFolder = "F:\Sync1RcBu"
$FoldersArray = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  #   gVim  Tabularize/,/l0l0l0  then view in a larger window
  #
  (1,"D:\Dropbox\CAM-fromSharon" ,"$backupFolder\Dr-CAM-fromSharon"    ,"F:\Sync1\Dr-CAM-fromSharon")    ,
  (1,"D:\Dropbox\CAMusic"        ,"$backupFolder\Dr-CAMusic"           ,"F:\Sync1\Dr-CAMusic")           ,
  (1,"D:\Dropbox\JH\Stack"       ,"$backupFolder\Dr-JH-Stack"          ,"F:\Sync1\Dr-JH-Stack")          ,
  (0,0                           ,0                                    ,0) # dummy row
  )

# Okay, go:
. $PSScriptRoot\Colours.ps1
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
. $PSScriptRoot\Sync.ps1
