param(
[string]$cnum
[string]$domain
)

$d = Get-Disk | Where-Object partitionstyle -eq 'RAW'
$driveLetter = 'G'
$d |
    Initialize-Disk -PartitionStyle GPT -PassThru |
    New-Partition -UseMaximumSize -DriveLetter $driveLetter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel "$cnum-DATA"  -Force

New-Item -Path "F:\" -Name "$cnum-UserProfiles" -ItemType "directory"

$NewAcl = Get-Acl -Path "F:\$cnum-UserProfiles"

$identity = "$domain\Domain Users"
$fileSystemRights = "Modify"
$type = "Allow"
$fileSystemAccessRuleArgumentList = $identity, $fileSystemRights, $type
$fileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $fileSystemAccessRuleArgumentList
$NewAcl.SetAccessRule($fileSystemAccessRule)
Set-Acl -Path "F:\$cnum-UserProfiles" -AclObject $NewAcl
