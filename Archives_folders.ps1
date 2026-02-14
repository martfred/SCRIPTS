$file = "C:\Users\adminmf\Desktop\Robocopy.txt"
if (Test-Path $file) {
    Remove-Item $file
}
New-Item -Path $file -ItemType File

$startdate = get-date "2016-01-01"
$enddate = get-date "2016-12-31"
$archivepath = "\\cima.plus\cima\Cima-C04\Archive\Projects"

$folders = Get-ChildItem -Path $folderPath -Directory | Where-Object {
    $_.LastWriteTime.Date -gt $startdate.Date -and $_.LastWriteTime.Date -lt $enddate.Date
} | Select-Object FullName, Name

foreach ($folder in $folders) {
    $robocopy = "robocopy " + """" + $folder.fullname + """" + " " + """" + $archivepath + "\" + $folder.Name + """" + " /E /IS /IT /MOVE /R:0 /W:0"
    add-content -Path $file -value $robocopy
}