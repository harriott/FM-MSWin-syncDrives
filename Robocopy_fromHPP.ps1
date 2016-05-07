# vim: set tw=0: http://momentary.eu/

# Joseph Harriott - Fri 06 May 2016
# Robocopy my personal file from HPP:11-n012na
# PS C:\Users\Joseph> E:\Files\IT_stack\Robocopy_fromHPP.ps1
# suffix these lines with /l to just list Robocopy's diagnosis without making any changes
# ----------------------------------------------------------------------------------------------
# E: MQ01ABF050
# G: Samsung M3
# H: K16GB500

$Folders = @( 
  (2,"E:\DropboxFiles\Copied","G:\Dr_Copied"),
  (2,"E:\DropboxFiles\Photos","G:\Dr_Photos"),
  (0,0,0)
  )
$IntFolder = "E:\DropboxFiles\Copied"
$ExtFolder = "G:\Dr_Copied"; $LogFile = $ExtFolder+"_fromHPP.log"
if ( $Folders[0][0] ) {
  $Command0 = "`"vim: nowrap tw=0: hi`" > $LogFile"
  $IntFolder = $Folders[0][1]
  $ExtFolder = $Folders[0][2]
  $Command1 = "robocopy /mir $IntFolder $ExtFolder /unilog+:$LogFile /tee"
  if ( $(Try { Test-Path $ExtFolder.trim() } Catch { $false }) ) {
    iex $Command0
    "" >> $LogFile
    "$Command0; $Command1" >> $LogFile
    iex $Command1
  } else {$ExtFolder+" ain't there"}
}
"vim: nowrap tw=0:" > H:\Now_fromHPP.log; robocopy /mir E:\DropboxFiles\Now H:\Now /unilog+:H:\Now_fromHPP.log /tee
# These are the wrong way around:
# "vim: nowrap tw=0:" > H:\Close_fromHPP.log; robocopy /mir H:\Close E:\DropboxFiles\Close /unilog+:H:\Close_fromHPP.log /tee
# "vim: nowrap tw=0:" > H:\Further_fromHPP.log; robocopy /mir H:\Further E:\DropboxFiles\Further /unilog+:H:\Further_fromHPP.log /tee
# "vim: nowrap tw=0:" > H:\Pointure_23_fromHPP.log; robocopy /mir H:\Pointure_23 E:\DropboxFiles\Pointure_23 /unilog+:H:\Pointure_23_fromHPP.log /tee /l
