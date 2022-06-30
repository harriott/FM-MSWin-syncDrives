
# Joseph Harriott

# Sync/backup my personal files to/from T430i73520M
# RCPD  is defined in  $machine\PSProfile.ps1

# Drives:
# C:
# E: SM3
$backupFolder = "E:\RcBu"
$FoldersArray = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  #   gVim  Tabularize/,/l0l0l0  then view in a larger window
  #
  (0,"$DROPBOX\CAM-best"              ,"$backupFolder\Dr-CAM-best"              ,"E:\Sync1Dr\CAM-best")              ,
  (0,"$DROPBOX\CAM-good"              ,"$backupFolder\Dr-CAM-good"              ,"E:\Sync1Dr\CAM-good")              ,
  (0,"$DROPBOX\CAT-Wellbeing"         ,"$backupFolder\Dr-CAT-Wellbeing"         ,"E:\Sync1Dr\CAT-Wellbeing")         ,
  (0,"$DROPBOX\COutThere"             ,"$backupFolder\Dr-COutThere"             ,"E:\Sync1Dr\COutThere")             ,
  (1,"$DROPBOX\JH\Cafezoide"          ,"$backupFolder\Dr-JH-Cafezoide"          ,"E:\Sync0Dr\JH-Cafezoide")          ,
  (1,"$DROPBOX\JH\CforWork"           ,"$backupFolder\Dr-JH-CforWork"           ,"E:\Sync0Dr\JH-CforWork")           ,
  (1,"$DROPBOX\JH\copied"             ,"$backupFolder\Dr-JH-copied"             ,"E:\Sync0Dr\JH-copied")             ,
  (1,"$DROPBOX\JH\core"               ,"$backupFolder\Dr-JH-core"               ,"E:\Sync0Dr\JH-core")               ,
  (1,"$DROPBOX\JH\F+F"                ,"$backupFolder\Dr-JH-F+F"                ,"E:\Sync0Dr\JH-F+F")                ,
  (1,"$DROPBOX\JH\now"                ,"$backupFolder\Dr-JH-now"                ,"E:\Sync0Dr\JH-now")                ,
  (1,"$DROPBOX\JH\stack"              ,"$backupFolder\Dr-JH-stack"              ,"E:\Sync0Dr\JH-stack")              ,
  (1,"$DROPBOX\JH\T91-default-release","$backupFolder\Dr-JH-T91-default-release","E:\Sync0Dr\JH-T91-default-release"),
  (1,"$DROPBOX\JH\technos"            ,"$backupFolder\Dr-JH-technos"            ,"E:\Sync0Dr\JH-technos")            ,
  (1,"$DROPBOX\JH\Theatre0"           ,"$backupFolder\Dr-JH-Theatre0"           ,"E:\Sync0Dr\JH-Theatre0")           ,
  (1,"$DROPBOX\JH\Theatre1"           ,"$backupFolder\Dr-JH-Theatre1"           ,"E:\Sync0Dr\JH-Theatre1")           ,
  (1,"$DROPBOX\JH\Then0"              ,"$backupFolder\Dr-JH-Then0"              ,"E:\Sync0Dr\JH-Then0")              ,
  (1,"$DROPBOX\JH\Then1"              ,"$backupFolder\Dr-JH-Then1"              ,"E:\Sync0Dr\JH-Then1")              ,
  (1,"$DROPBOX\JH\toReduce"           ,"$backupFolder\Dr-JH-toReduce"           ,"E:\Sync0Dr\JH-toReduce")           ,
  (1,"$DROPBOX\JH\Work"               ,"$backupFolder\Dr-JH-Work"               ,"E:\Sync0Dr\JH-Work")               ,
  (1,"$DROPBOX\Photos"                ,"$backupFolder\Dr-Photos"                ,"E:\Sync0Dr\Photos")                ,
  (0,0                                ,0                                        ,0) # dummy row
  )

$createTargets = 1  # comment out...

# Okay, go:
$parent=(get-item $PSScriptRoot).parent.fullname
. $parent\Colours.ps1
$ThisScript = $MyInvocation.InvocationName+'.ps1'
. $parent\Sync.ps1

