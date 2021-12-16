
# Joseph Harriott

# Sync/backup my personal files to/from T430i73520M

# Drives:
# C:
# E: SM3
$backupFolder = "E:\RcBu"
$FoldersArray = @(
  # first element of each row allows for that row to be switched off, by setting to 0
  #   gVim  Tabularize/,/l0l0l0  then view in a larger window
  #
  (0, "$DROPBOX\CAM-favs",              "$backupFolder\Dr-CAM-favs",              "E:\Sync1Dr\CAM-favs"),
  (0, "$DROPBOX\CAT-Wellbeing",         "$backupFolder\Dr-CAT-Wellbeing",         "E:\Sync0Dr\CAT-Wellbeing"),
  (0, "$DROPBOX\COutThere",             "$backupFolder\Dr-COutThere",             "E:\Sync0Dr\COutThere"),
  (1, "$DROPBOX\JH\Cafezoide",          "$backupFolder\Dr-JH-Cafezoide",          "E:\Sync0Dr\JH-Cafezoide"),
  (1, "$DROPBOX\JH\CforWork",           "$backupFolder\Dr-JH-CforWork",           "E:\Sync0Dr\JH-CforWork"),
  (1, "$DROPBOX\JH\core",               "$backupFolder\Dr-JH-core",               "E:\Sync0Dr\JH-core"),
  (1, "$DROPBOX\JH\F+F",                "$backupFolder\Dr-JH-F+F",                "E:\Sync0Dr\JH-F+F"),
  (1, "$DROPBOX\JH\Now",                "$backupFolder\Dr-JH-Now",                "E:\Sync0Dr\JH-Now"),
  (1, "$DROPBOX\JH\Technos",            "$backupFolder\Dr-JH-Technos",            "E:\Sync0Dr\JH-Technos"),
  (1, "$DROPBOX\JH\Theatre0",           "$backupFolder\Dr-JH-Theatre0",           "E:\Sync0Dr\JH-Theatre0"),
  (1, "$DROPBOX\JH\Theatre1",           "$backupFolder\Dr-JH-Theatre1",           "E:\Sync0Dr\JH-Theatre1"),
  (1, "$DROPBOX\JH\Then0",              "$backupFolder\Dr-JH-Then0",              "E:\Sync0Dr\JH-Then0"),
  (1, "$DROPBOX\JH\Then1",              "$backupFolder\Dr-JH-Then1",              "E:\Sync0Dr\JH-Then1"),
  (1, "$DROPBOX\JH\toReduce",           "$backupFolder\Dr-JH-toReduce",           "E:\Sync0Dr\JH-toReduce"),
  (1, "$DROPBOX\JH\TP.default-release", "$backupFolder\Dr-JH-TP.default-release", "E:\Sync0Dr\JH-TP.default-release"),
  (1, "$DROPBOX\JH\Work",               "$backupFolder\Dr-JH-Work",               "E:\Sync0Dr\JH-Work"),
  (1, "$DROPBOX\Photos",                "$backupFolder\Dr-Photos",                "E:\Sync0Dr\Photos"),
  (0, 0,                                  0,                                        0) # dummy row
  )

# Okay, go:
$parent=(get-item $PSScriptRoot).parent.fullname
. $parent\Colours.ps1
$ThisScript = $MyInvocation.InvocationName+'.ps1'
. $parent\Sync.ps1
