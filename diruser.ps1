
Specify the path.
$folder = 'D:\'

$DirUseArray = @()
 
$startTime =  (Get-Date).ToString("dd_MM_yyyy_HH_mm_ss")
 
# Get a list of first level sub-folders
$firstLevel = Get-ChildItem $folder -directory
 
$firstLevel | foreach {
   Echo "Reading $_"
   # Read the size of this folder and all its sub folders.
   $size = (Get-ChildItem $folder\$_\* -recurse) | measure-object -property length -sum | Select-Object -expand sum
 
   # Convert from Bytes to GiB and round to 2 decimal places
   $size =  [math]::Round($(0 + $size /1GB),2)
   Echo $size
 
   # Add to an array
   $DirUseArray += New-Object PsObject -property @{
      'Folder' = $_
      'Size (GB)' = $size
   }
}
$DirUseArray | Export-Csv -path D:\projetos\dir-user\$startTime.csv -NoTypeInformation