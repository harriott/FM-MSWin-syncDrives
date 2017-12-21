# Joseph Harriott  http://momentary.eu/  Thu 21 Dec 2017

# Sync/backup my personal files to/from HPP:11-n012na
# PS C:\Users\Joseph> E:\Files\IT_stack\SyncPortableDrives\RobocopyHPP.ps1
# suffix these lines with /l to just list Robocopy's diagnosis without making any changes
# ----------------------------------------------------------------------------------------------

# E: MQ01ABF050
# F: Samsung M3
# G: K16GB500
$backupFolder = "F:\Robocopy-backup-HPP"
$FoldersArray = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  #   gVim  Tabularize/,/l0l0l0  then view in a larger window
  #
  (0,"E:\Dropbox\CA-Buddhism"       ,"$backupFolder\Dr-CA-Buddhism"       ,"F:\Sync\Dr-CA-Buddhism")       ,
  (0,"E:\Dropbox\CA-OutThere-UK"    ,"$backupFolder\Dr-CA-OutThere-UK"    ,"F:\Sync\Dr-CA-OutThere-UK")    ,
  (0,"E:\Dropbox\CA-Theravada"      ,"$backupFolder\Dr-CA-Theravada"      ,"F:\Sync\Dr-CA-Theravada")      ,
  (0,"E:\Dropbox\CAMusic-Europe"    ,"$backupFolder\Dr-CAMusic-Europe"    ,"F:\Sync\Dr-CAMusic-Europe")    ,
  (0,"E:\Dropbox\CAMusic-fromSharon","$backupFolder\Dr-CAMusic-fromSharon","F:\Sync\Dr-CAMusic-fromSharon"),
  (0,"E:\Dropbox\CAMusic-Germanic"  ,"$backupFolder\Dr-CAMusic-Germanic"  ,"F:\Sync\Dr-CAMusic-Germanic")  ,
  (0,"E:\Dropbox\CAMusic-USA"       ,"$backupFolder\Dr-CAMusic-USA"       ,"F:\Sync\Dr-CAMusic-USA")       ,
  (0,"E:\Dropbox\CAMusic-West"      ,"$backupFolder\Dr-CAMusic-West"      ,"F:\Sync\Dr-CAMusic-West")      ,
  (0,"E:\Dropbox\CAMusic-World"     ,"$backupFolder\Dr-CAMusic-World"     ,"F:\Sync\Dr-CAMusic-World")     ,
  (0,"E:\Dropbox\CAudio-OutThere"   ,"$backupFolder\Dr-CAudio-OutThere"   ,"F:\Sync\Dr-CAudio-OutThere")   ,
  (0,"E:\Dropbox\Copied-OutThere"   ,"$backupFolder\Dr-Copied-OutThere"   ,"F:\Sync\Dr-Copied-OutThere")   ,
  (0,"E:\Dropbox\JH\Copied"         ,"$backupFolder\Dr-JH-Copied"         ,"F:\Sync\Dr-JH-Copied")         ,
  (0,"E:\Dropbox\JH\F+F"            ,"$backupFolder\Dr-JH-F+F"            ,"F:\Sync\Dr-JH-F+F")            ,
  (0,"E:\Dropbox\JH\IT_stack"       ,"$backupFolder\Dr-JH-IT_stack"       ,"F:\Sync\Dr-JH-IT_stack")       ,
  (0,"E:\Dropbox\JH\Now"            ,"$backupFolder\Dr-JH-Now"            ,"F:\Sync\Dr-JH-Now")            ,
  (0,"E:\Dropbox\JH\Stack"          ,"$backupFolder\Dr-JH-Stack"          ,"F:\Sync\Dr-JH-Stack")          ,
  (0,"E:\Dropbox\JH\Theatre0"       ,"$backupFolder\Dr-JH-Theatre0"       ,"F:\Sync\Dr-JH-Theatre0")       ,
  (0,"E:\Dropbox\JH\Theatre1"       ,"$backupFolder\Dr-JH-Theatre1"       ,"F:\Sync\Dr-JH-Theatre1")       ,
  (0,"E:\Dropbox\JH\Then0"          ,"$backupFolder\Dr-JH-Then0"          ,"F:\Sync\Dr-JH-Then0")          ,
  (0,"E:\Dropbox\JH\Then1"          ,"$backupFolder\Dr-JH-Then1"          ,"F:\Sync\Dr-JH-Then1")          ,
  (0,"E:\Dropbox\JH\toReduce"       ,"$backupFolder\Dr-JH-toReduce"       ,"F:\Sync\Dr-JH-toReduce")       ,
  (0,"E:\Dropbox\JH\Work"           ,"$backupFolder\Dr-JH-Work"           ,"F:\Sync\Dr-JH-Work")           ,
  (0,"E:\Dropbox\Photos"            ,"$backupFolder\Dr-Photos"            ,"F:\Sync\Dr-Photos")            ,
  (1,"E:\IT-Copied"                 ,"$backupFolder\IT-Copied"            ,"F:\Sync\IT-Copied")            ,
  (0,"E:\IT-DebianBased-Copied"     ,"$backupFolder\IT-DebianBased-Copied","F:\Sync\IT-DebianBased-Copied"),
  (0,"E:\More"                      ,"$backupFolder\More"                 ,"F:\Sync\More")                 ,
  (0,0                              ,0                                    ,0) # dummy row
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

# Prepare a file to log all of the changes made:
$ThisScript = $PSCommandPath.TrimStart($PSScriptRoot)
$ChangesLog = "E:\"+$ThisScript.TrimEnd("ps1")+"log"
if ( Test-Path $ChangesLog ) { ri $ChangesLog } # to have current date assigned to $ChangesLog
"vim: nowrap tw=0:" > $ChangesLog
"" >> $ChangesLog
if ( $simulate ) { $simulated = " (SIMULATED)" } else { $simulated ="" }
"Changes made by $ThisScript$simulated`:" >> $ChangesLog

# Attempt to do the work requested:
foreach ($FolderControl in $FoldersArray) {
  # check that this folder is wanted:
  if ( $FolderControl[0] ) {
    # prepare the from & to folders:
    $AintThere = ""
    if ($reply -ceq "b") {
      $frFolder = $FolderControl[1]
      $toFolder = $FolderControl[2]
      if ( ! $(Try { Test-Path $toFolder.trim() } Catch { $false }) ) { $AintThere = "Sorry, $toFolder  ain't there." }
      $LogFile = $toFolder+".log"
    } else {
      $FAT = " /fft" # allows for fractional times on external drive
      $FolderControl3 = $FolderControl[3]
      if ( ! $(Try { Test-Path $FolderControl3.trim() } Catch { $false }) ) {
          $AintThere = "Sorry, $FolderControl3  ain't there." }
      if ($reply -eq "t") {
        $frFolder = $FolderControl[1]
        $toFolder = $FolderControl3
        $LogFile = $toFolder+"_fromHPP.log"
      } else {
        $frFolder = $FolderControl3
        $toFolder = $FolderControl[1]
        $LogFile = $frFolder+"_toHPP.log"
      }
    }
    # ready to go ahead, prepare:
    $frFolder
    $toFolder
    # do the Robocopy:
    if ($AintThere) {
      [System.Console]::ForegroundColor = 'Yellow'
      $AintThere
      [System.Console]::ResetColor()
      ""
      "" >> $ChangesLog
      "$AintThere" >> $ChangesLog
    } else {
      $LogFile
      "vim: nowrap tw=0:" > $LogFile
      "" >> $LogFile
      $Command1 = "robocopy /mir $frFolder $toFolder /np /unilog+:$LogFile /tee"+$simulate+$FAT
      [System.Console]::ForegroundColor = 'Yellow'
      $Command1
      [System.Console]::ResetColor()
      "$Command1" >> $LogFile
      iex $Command1 # Comment this line to disable the file copying
      # log the changes:
      "" >> $ChangesLog
      $Command1 >> $ChangesLog
      "logging any changes to $ChangesLog"
      ""
      gc $LogFile | select-string '    New File|    Newer|    Older|`*EXTRA File|  New Dir|`*EXTRA Dir' >> $ChangesLog
    }
  }
}
""

# Sign off:
Write-Host "All done and logged individually, with all of the changes saved together to  $ChangesLog" -background darkcyan -foreground white
""
