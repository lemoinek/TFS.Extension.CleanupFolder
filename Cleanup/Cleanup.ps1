param (
[string]$path ,
[int]$retentionDays,
[int]$minimumToKeep
)

$folderlist = Get-ChildItem $path | sort @{Expression={$_.LastWriteTime}; Ascending=$false}

$keepDate = (Get-Date).AddDays(-$retentionDays)
$keeping = 0

ForEach ($folder In $folderlist) {
    
    if($folder.LastWriteTime -lt $keepDate -And $minimumToKeep -le $keeping)
    {
       Write-Output "Deleting $($folder.FullName)"
       Remove-Item $folder.FullName
    }
    else
    {
        $keeping++
    }
}

 Write-Output "Keeping $($keeping) files/folders."