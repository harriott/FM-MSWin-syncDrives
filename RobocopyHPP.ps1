# vim: set tw=0: http://momentary.eu/

# Joseph Harriott - Tue 10 May 2016
# Sync/backup my personal files to/from HPP:11-n012na
# PS C:\Users\Joseph> E:\Files\IT_stack\SyncPortableDrives\RobocopyHPP.ps1
# suffix these lines with /l to just list Robocopy's diagnosis without making any changes
# ----------------------------------------------------------------------------------------------
# E: MQ01ABF050
# G: Samsung M3
# H: K16GB500

"This Powershell script will use Robocopy to mirror my personal folders."
[System.Console]::BackgroundColor = 'DarkCyan'
[System.Console]::ForegroundColor = 'White'
$input = Read-Host 'Do you want to backup (b), or mirror TO (T) portable drives (or simulate (t)),  or mirror FROM (F) (or simulate (f))?'
[System.Console]::ResetColor()

$Folders = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  (0,"E:\DropboxFiles\Close","G:\Robocopy-backup-HPP\Close","H:\Close"),
  (0,"E:\DropboxFiles\Copied","G:\Robocopy-backup-HPP\Copied","G:\Dr_Copied"),
  (0,"E:\DropboxFiles\Further","G:\Robocopy-backup-HPP\Further","H:\Further"),
  (0,"E:\DropboxFiles\Now","G:\Robocopy-backup-HPP\Now","H:\Now"),
  (0,"E:\DropboxFiles\Photos","G:\Robocopy-backup-HPP\Photos","G:\Dr_Photos"),
  (0,"E:\DropboxFiles\Pointure_23","G:\Robocopy-backup-HPP\Pointure_23","G:\Dr_Pointure_23"),
  (0,"E:\Files","G:\Robocopy-backup-HPP\Files","G:\Files"),
  (0,0,0) # dummy row
  )
$Changes = $PSCommandPath.TrimEnd("ps1")+"log"
foreach ($Fpair in $Folders) {
  if ( $Fpair[0] ) {
    $IntFolder = $Fpair[1]; $IntFolder
    $ExtFolder = $Fpair[2]; $ExtFolder
    $LogFile = $ExtFolder+".log"; $LogFile
    $Command0 = "`"vim: nowrap tw=0: hi`" > $LogFile"
    $Command1 = "robocopy /mir $IntFolder $ExtFolder /np /unilog+:$LogFile /tee"
    if ( $(Try { Test-Path $ExtFolder.trim() } Catch { $false }) ) {
      iex $Command0
      "" >> $LogFile
      "$Command0; $Command1" >> $LogFile
      iex $Command1
    } else {$ExtFolder+" ain't there"}
  }
}
Write-Host "All done and logged individually, with all of the changes saved together to $Changes" -background darkcyan -foreground white
