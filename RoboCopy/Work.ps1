
# Joseph Harriott  Thu 30 Jun 2022

# sourced by  Sync.ps1

# Prepare a file to log all of the changes made:
if ( Test-Path $ChangesLog ) { ri $ChangesLog } # to have current date assigned to $ChangesLog
"vim: nowrap tw=0:" > $ChangesLog
"" >> $ChangesLog
if ( $simulate ) { $simulated = " (SIMULATED)" } else { $simulated ="" }
"Changes made by $ThisScript$simulated`:" >> $ChangesLog

Function tp {
  $at = $args[0].trim()
  if ( ! $(Try { Test-Path $at } Catch { $false }) ) {
    if ($createTargets) { ni $at -type directory }
    else { $global:AintThere = "Sorry, $at  ain't there." }
  }
}

# Attempt to do the work requested:
foreach ($FolderControl in $FoldersArray) {
  # check that this folder is wanted:
  if ( $FolderControl[0] ) {
    # prepare the from & to folders:
    $global:AintThere = ""
    if ($reply -ceq "b") {
      $frFolder = $FolderControl[1]
      $toFolder = $FolderControl[2]
      tp $toFolder
      $LogFile = $toFolder+".log"
    } else {
      $FAT = " /fft" # allows for fractional times on external drive
      $FolderControl3 = $FolderControl[3]
      # if ( ! $(Try { Test-Path $FolderControl3.trim() } Catch { $false }) ) {
          # $global:AintThere = "Sorry, $FolderControl3  ain't there." }
      if ($reply -eq "t") {
        $frFolder = $FolderControl[1]
        $toFolder = $FolderControl3
        $LogFile = $toFolder+"_from$Env:Computername.log"
      } else {
        $frFolder = $FolderControl3
        $toFolder = $FolderControl[1]
        $LogFile = $frFolder+"_to$Env:Computername.log"
      }
      tp $toFolder
    }
    # ready to go ahead, prepare:
    "from: $frFolder"
    "  to: $toFolder"
    # do the Robocopy:
    # if ($create) { $AintThere = '' }
    if ($global:AintThere) {
      [System.Console]::ForegroundColor = 'Yellow'
      $global:AintThere
      [System.Console]::ResetColor()
      ""
      "" >> $ChangesLog
      "$global:AintThere" >> $ChangesLog
    } else {
      " log: $LogFile"
      "vim: nowrap tw=0:" > $LogFile
      "" >> $LogFile
      $Command1 = "robocopy /mir $frFolder $toFolder $Progress /unilog+:$LogFile /tee"+$simulate+$FAT
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
gvim -c "set columns=217 lines=54 | silent! /robocopy\ \/mir" $ChangesLog
""

