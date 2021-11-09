$d = Get-Disk | Where-Object partitionstyle -eq 'RAW'
$driveLetter = 'G'
$d |
    Initialize-Disk -PartitionStyle GPT -PassThru |
    New-Partition -UseMaximumSize -DriveLetter $driveLetter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel 'Data0'  -Force
