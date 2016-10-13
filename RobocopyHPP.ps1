# vim: set et tw=0:  http://momentary.eu/

# Joseph Harriott - Thu 13 Oct 2016
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
  (1,"E:\Dropbox\Copied"               ,"$backupFolder\Dr-Copied"               ,"F:\Sync\Copied")               ,
  (1,"E:\Dropbox\Copied-Music-toPlay"  ,"$backupFolder\Dr-Copied-Music-toPlay"  ,"F:\Sync\Copied-Music-toPlay")  ,
  (1,"E:\Dropbox\Copied-OutThere-Audio","$backupFolder\Dr-Copied-OutThere-Audio","F:\Sync\Copied-OutThere-Audio"),
  (1,"E:\Dropbox\Copied-UK-Audio"      ,"$backupFolder\Dr-Copied-UK-Audio"      ,"F:\Sync\Copied-UK-Audio")      ,
  (1,"E:\Dropbox\JH\Close"             ,"$backupFolder\Dr-JH-Close"             ,"G:\Close")                     ,
  (1,"E:\Dropbox\JH\F+F"               ,"$backupFolder\Dr-JH-F+F"               ,"F:\Sync\JH-F+F")               ,
  (1,"E:\Dropbox\JH\Further"           ,"$backupFolder\Dr-JH-Further"           ,"G:\Further")                   ,
  (1,"E:\Dropbox\JH\Now"               ,"$backupFolder\Dr-JH-Now"               ,"G:\Now")                       ,
  (1,"E:\Dropbox\JH\Stack"             ,"$backupFolder\Dr-JH-Stack"             ,"F:\Sync\JH-Stack")             ,
  (1,"E:\Dropbox\JH\Theatre"           ,"$backupFolder\Dr-JH-Theatre"           ,"F:\Sync\JH-Theatre")           ,
  (1,"E:\Dropbox\JH\Work"              ,"$backupFolder\Dr-JH-Work"              ,"G:\Work")                      ,
  (1,"E:\Dropbox\Photos"               ,"$backupFolder\Dr-Photos"               ,"F:\Sync\Photos")               ,
  (1,"E:\IT-Copied"                    ,"$backupFolder\IT-Copied"               ,"F:Sync\IT-Copied")             ,
  (1,"E:\IT-DebianBased-Copied"        ,"$backupFolder\IT-DebianBased-Copied"   ,"F:Sync\IT-DebianBased-Copied") ,
  (1,"E:\More"                         ,"$backupFolder\More"                    ,"F:Sync\More")                  ,
  (0,0                                 ,0                                       ,0) # dummy row
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
      $FolderControl3 = $FolderControl[3]
      if ( ! $(Try { Test-Path $FolderControl3.trim() } Catch { $false }) ) {
          $AintThere = "Sorry, $FolderControl3  ain't there." }
      if ( $FolderControl3 -match "^G:" ) { $FAT = " /fft" } else { $FAT ="" }
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
    $LogFile
    $Command0 = "`"vim: nowrap tw=0:`" > $LogFile"
    # do the Robocopy:
    iex $Command0
    "" >> $LogFile
    if ($AintThere) {
      [System.Console]::ForegroundColor = 'Yellow'
      $AintThere
      [System.Console]::ResetColor()
      ""
      "$AintThere" >> $LogFile
    } else {
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
