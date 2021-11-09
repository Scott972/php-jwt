$d = Get-Disk | Where-Object partitionstyle -eq 'RAW'
$label = 'G'
$d |
    Initialize-Disk -PartitionStyle GPT -PassThru |
    New-Partition -UseMaximumSize -DriveLetter $driveLetter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel 'Data0'  -Force