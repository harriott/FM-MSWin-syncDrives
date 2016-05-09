# vim: set tw=0: http://momentary.eu/

# Joseph Harriott - Sat 07 May 2016
# Backup my personal file from HPP:11-n012na
# PS C:\Users\Joseph> E:\Files\IT_stack\Robocopy_backupHPP.ps1
# suffix these lines with /l to just list Robocopy's diagnosis without making any changes
# ----------------------------------------------------------------------------------------------
# E: MQ01ABF050
# G: Samsung M3
# H: K16GB500

$Folders = @(
  (1,"E:\DropboxFiles\Close","G:\Robocopy-backup-HPP\Close","H:\Close"),
  (1,"E:\DropboxFiles\Copied","G:\Robocopy-backup-HPP\Copied","G:\Dr_Copied"),
  (1,"E:\DropboxFiles\Further","G:\Robocopy-backup-HPP\Further","H:\Further"),
  (1,"E:\DropboxFiles\Now","G:\Robocopy-backup-HPP\Now","H:\Now"),
  (1,"E:\DropboxFiles\Photos","G:\Robocopy-backup-HPP\Photos","G:\Dr_Photos"),
  (1,"E:\DropboxFiles\Pointure_23","G:\Robocopy-backup-HPP\Pointure_23","G:\Dr_Pointure_23"),
  (1,"E:\Files","G:\Robocopy-backup-HPP\Files","G:\Files"),
  (0,0,0)
  )
echo @($Folders).length
foreach ($Fpair in $Folders) {
  if ( $Fpair[0] ) {
    $IntFolder = $Fpair[1]
    $IntFolder
    $ExtFolder = $Fpair[2]
    $ExtFolder
    $LogFile = $ExtFolder+".log"
    $LogFile
    $Command0 = "`"vim: nowrap tw=0: hi`" > $LogFile"
    $Command1 = "robocopy /mir $IntFolder $ExtFolder /unilog+:$LogFile /tee"
    if ( $(Try { Test-Path $ExtFolder.trim() } Catch { $false }) ) {
      iex $Command0
      "" >> $LogFile
      "$Command0; $Command1" >> $LogFile
      # iex $Command1
    } else {$ExtFolder+" ain't there"}
  }
}
# "vim: nowrap tw=0:" > H:\Now_fromHPP.log; robocopy /mir E:\DropboxFiles\Now H:\Now /unilog+:H:\Now_fromHPP.log /tee
# These are the wrong way around:
# "vim: nowrap tw=0:" > H:\Close_fromHPP.log; robocopy /mir H:\Close E:\DropboxFiles\Close /unilog+:H:\Close_fromHPP.log /tee
# "vim: nowrap tw=0:" > H:\Further_fromHPP.log; robocopy /mir H:\Further E:\DropboxFiles\Further /unilog+:H:\Further_fromHPP.log /tee
# "vim: nowrap tw=0:" > H:\Pointure_23_fromHPP.log; robocopy /mir H:\Pointure_23 E:\DropboxFiles\Pointure_23 /unilog+:H:\Pointure_23_fromHPP.log /tee /l
