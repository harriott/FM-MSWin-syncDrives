
# Joseph Harriott - http://harriott.github.io - Mon 04 Mar 2024

# $onGH/FM-MSWin-syncDrives/RC-machines/HPEB840G37.ps1

# sync/backup my personal files to/from a Win10 machine

# Drives:
# C:
# D: WD30EZRZ
$backupFolder = "D:\RcBu"
$FoldersArray = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  #   gVim  Tabularize/,/l0l0l0  then view in a larger window
  #
  (1,"$Drpbx\CAM-best"         ,"$backupFolder\Dr-CAM-best"         ,"D:\Sync1Dr\CAM-best")         ,
  (1,"$Drpbx\CAM-joy"          ,"$backupFolder\Dr-CAM-joy"          ,"D:\Sync1Dr\CAM-joy")          ,
  (1,"$Drpbx\COutThere"        ,"$backupFolder\Dr-COutThere"        ,"D:\Sync1Dr\COutThere")        ,
  (1,"$Drpbx\JH\Cafezoide"     ,"$backupFolder\Dr-JH-Cafezoide"     ,"D:\Sync0Dr\JH\Cafezoide")     ,
  (1,"$Drpbx\JH\CforWork"      ,"$backupFolder\Dr-JH-CforWork"      ,"D:\Sync0Dr\JH\CforWork")      ,
  (1,"$Drpbx\JH\copied"        ,"$backupFolder\Dr-JH-copied"        ,"D:\Sync0Dr\JH\copied")        ,
  (1,"$Drpbx\JH\core"          ,"$backupFolder\Dr-JH-core"          ,"D:\Sync0Dr\JH\core")          ,
  (1,"$Drpbx\JH\Cz-imagesFlat" ,"$backupFolder\Dr-JH-Cz-imagesFlat" ,"D:\Sync0Dr\JH\Cz-imagesFlat") ,
  (1,"$Drpbx\JH\F+F"           ,"$backupFolder\Dr-JH-F+F"           ,"D:\Sync0Dr\JH\F+F")           ,
  (1,"$Drpbx\JH\JCD-imagey-e3" ,"$backupFolder\Dr-JH-JCD-imagey-e3" ,"D:\Sync0Dr\JH\JCD-imagey-e3") ,
  (1,"$Drpbx\JH\now"           ,"$backupFolder\Dr-JH-now"           ,"D:\Sync0Dr\JH\now")           ,
  (1,"$Drpbx\JH\Play0"         ,"$backupFolder\Dr-JH-Play0"         ,"D:\Sync0Dr\JH\Play0")         ,
  (1,"$Drpbx\JH\Play1"         ,"$backupFolder\Dr-JH-Play1"         ,"D:\Sync0Dr\JH\Play1")         ,
  (1,"$Drpbx\JH\search"        ,"$backupFolder\Dr-JH-search"        ,"D:\Sync0Dr\JH\search")        ,
  (1,"$Drpbx\JH\Sh-AsusW202"   ,"$backupFolder\Dr-JH-Sh-AsusW202"   ,"D:\Sync0Dr\JH\Sh-AsusW202")   ,
  (1,"$Drpbx\JH\Sh-i34G1TU02"  ,"$backupFolder\Dr-JH-Sh-i34G1TU02"  ,"D:\Sync0Dr\JH\Sh-i34G1TU02")  ,
  (1,"$Drpbx\JH\Sh-OppoA76"    ,"$backupFolder\Dr-JH-Sh-OppoA76"    ,"D:\Sync0Dr\JH\Sh-OppoA76")    ,
  (1,"$Drpbx\JH\Sh-sbMb"       ,"$backupFolder\Dr-JH-Sh-sbMb"       ,"D:\Sync0Dr\JH\Sh-sbMb")       ,
  (1,"$Drpbx\JH\Sh-T430i73520M","$backupFolder\Dr-JH-Sh-T430i73520M","D:\Sync0Dr\JH\Sh-T430i73520M"),
  (1,"$Drpbx\JH\Sh-XA10II"     ,"$backupFolder\Dr-JH-Sh-XA10II"     ,"D:\Sync0Dr\JH\Sh-XA10II")     ,
  (1,"$Drpbx\JH\stack"         ,"$backupFolder\Dr-JH-stack"         ,"D:\Sync0Dr\JH\stack")         ,
  (1,"$Drpbx\JH\technos"       ,"$backupFolder\Dr-JH-technos"       ,"D:\Sync0Dr\JH\technos")       ,
  (1,"$Drpbx\JH\Thb-dr"        ,"$backupFolder\Dr-JH-Thb-dr"        ,"D:\Sync0Dr\JH\Thb-dr")        ,
  (1,"$Drpbx\JH\Theatre0"      ,"$backupFolder\Dr-JH-Theatre0"      ,"D:\Sync0Dr\JH\Theatre0")      ,
  (1,"$Drpbx\JH\Theatre1"      ,"$backupFolder\Dr-JH-Theatre1"      ,"D:\Sync0Dr\JH\Theatre1")      ,
  (1,"$Drpbx\JH\Then0"         ,"$backupFolder\Dr-JH-Then0"         ,"D:\Sync0Dr\JH\Then0")         ,
  (1,"$Drpbx\JH\Then1"         ,"$backupFolder\Dr-JH-Then1"         ,"D:\Sync0Dr\JH\Then1")         ,
  (1,"$Drpbx\JH\work"          ,"$backupFolder\Dr-JH-work"          ,"D:\Sync0Dr\JH\work")          ,
  (1,"$Drpbx\Photos"           ,"$backupFolder\Dr-Photos"           ,"D:\Sync0Dr\Photos")           ,
  (0,0                         ,0                                   ,0) # dummy row
  )

$createTargets = 1  # comment out...

# Okay, go:
. $onGH/FM-MSWin-syncDrives/RC-work/0-colours.ps1
$ThisScript = $MyInvocation.InvocationName+'.ps1'
  . $onGH/FM-MSWin-syncDrives/RC-work/1-sync.ps1

