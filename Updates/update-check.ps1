# Get the latest updates within seven days

$boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$date = Get-Date
$updates = Get-HotFix | sort "InstalledOn" -Descending | where -Property "InstalledOn" -gT  $date.AddDays(-7) 
foreach($up in $updates){
    $hotfix = $up.hotfixid
    $installdate = $up.InstalledOn
    $category = $up.description
    Write-Host "The follwing update $hotfix with category of $category was installed on $installdate" -ForegroundColor Yellow
}Write-Host "Last boot time was $boot" -ForegroundColor Yellow

# Check for Pending Reboot
    If (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) {
        Write-Host "Pending reboot detected by Windows Update."
    }