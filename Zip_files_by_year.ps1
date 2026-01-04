Function Zip_logs($repertoire, $annee)
{
    $tempDir = "D:\Temp" 
    New-Item -Path $tempDir -ItemType Directory

    if (-Not (Test-Path $repertoire)) {
        Write-Host "Le répertoire spécifié n'existe pas."
        exit
    }

    $fichiers = Get-ChildItem -Path $repertoire -Recurse | Where-Object {
        $_.LastWriteTime.Year -eq $annee
    }

    if ($fichiers.Count -gt 0) 
    {
        write-host "Archivage : " $repertoire -ForegroundColor Blue
        # Définir le nom du fichier zip
        $zipFileName = "$repertoire\$annee.zip"

        # Copier les fichiers filtrés dans ce dossier temporaire
        foreach ($fichier in $fichiers) 
        {
            move-Item -Path $fichier.FullName -Destination $tempDir
        }

        # Utiliser la cmdlet Compress-Archive pour créer le fichier zip
        Compress-Archive -Path "$tempDir\*" -DestinationPath $zipFileName -Force
     }
     Remove-Item -Path $tempDir -Recurse -Force
}

cls
$year = 2019
$AllFolders = Get-ChildItem -Path "D:\100\TI\Logs\TreeSizePro" -Directory

foreach ($folder in $AllFolders) 
{
    write-host  $folder.FullName
    Zip_logs  $folder.FullName $year
}
