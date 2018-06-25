# Joseph Harriott  http://momentary.eu/  Mon 25 Jun 2018

# Sync/backup my personal files to/from HPP:11-n012na
# PS> D:\Dropbox\JH\IT_stack\onGitHub\SyncPortableDrives\RobocopyHPP.ps1
# ----------------------------------------------------------------------

# Drives:
# D: BX200
# F: SM3
$backupFolder = "F:\Sync0RcBu"
$FoldersArray = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  #   gVim  Tabularize/,/l0l0l0  then view in a larger window
  #
  (1,"D:\Dropbox\Copied-OutThere","$backupFolder\Dr-Copied-OutThere"   ,"F:\Sync0\Dr-Copied-OutThere")   ,
  (1,"D:\Dropbox\JH\Copied"      ,"$backupFolder\Dr-JH-Copied"         ,"F:\Sync0\Dr-JH-Copied")         ,
  (1,"D:\Dropbox\JH\F+F"         ,"$backupFolder\Dr-JH-F+F"            ,"F:\Sync0\Dr-JH-F+F")            ,
  (1,"D:\Dropbox\JH\IT_stack"    ,"$backupFolder\Dr-JH-IT_stack"       ,"F:\Sync0\Dr-JH-IT_stack")       ,
  (1,"D:\Dropbox\JH\Now"         ,"$backupFolder\Dr-JH-Now"            ,"F:\Sync0\Dr-JH-Now")            ,
  (1,"D:\Dropbox\JH\Theatre0"    ,"$backupFolder\Dr-JH-Theatre0"       ,"F:\Sync0\Dr-JH-Theatre0")       ,
  (1,"D:\Dropbox\JH\Theatre1"    ,"$backupFolder\Dr-JH-Theatre1"       ,"F:\Sync0\Dr-JH-Theatre1")       ,
  (1,"D:\Dropbox\JH\Then0"       ,"$backupFolder\Dr-JH-Then0"          ,"F:\Sync0\Dr-JH-Then0")          ,
  (1,"D:\Dropbox\JH\Then1"       ,"$backupFolder\Dr-JH-Then1"          ,"F:\Sync0\Dr-JH-Then1")          ,
  (1,"D:\Dropbox\JH\toReduce"    ,"$backupFolder\Dr-JH-toReduce"       ,"F:\Sync0\Dr-JH-toReduce")       ,
  (1,"D:\Dropbox\JH\Work"        ,"$backupFolder\Dr-JH-Work"           ,"F:\Sync0\Dr-JH-Work")           ,
  (1,"D:\Dropbox\Photos"         ,"$backupFolder\Dr-Photos"            ,"F:\Sync0\Dr-Photos")            ,
  (0,0                           ,0                                    ,0) # dummy row
  )

# Okay, go:
. $PSScriptRoot\Colours.ps1
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
. $PSScriptRoot\Sync.ps1
