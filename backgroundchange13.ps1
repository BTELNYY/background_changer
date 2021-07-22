#Import Assembly
add-content -path ".\Logs\$date.log" -value "Importing Assembly!"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Screen]::AllScreens
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$date = Get-Date
$DebugPrefrence = "Continue"
write-debug "Finished Installing assembly"
Function Set-WallPaper($Value)
{

 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value

 rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True

}
write-host "Your Resultion Is:"
Function Screen-Info
{
$screen_cnt  = [System.Windows.Forms.Screen]::AllScreens.Count
$col_screens = [system.windows.forms.screen]::AllScreens

$info_screens = ($col_screens | ForEach-Object {
if ("$($_.Primary)" -eq "True") {$monitor_type = "Primary Monitor    "} else {$monitor_type = "Secondary Monitor  "}
if ("$($_.Bounds.Width)" -gt "$($_.Bounds.Height)") {$monitor_orientation = "Landscape"} else {$monitor_orientation = "Portrait"}
$monitor_type + "(Bounds)                          " + "$($_.Bounds)"
$monitor_type + "(Primary)                         " + "$($_.Primary)"
$monitor_type + "(Device Name)                     " + "$($_.DeviceName)"
$monitor_type + "(Bounds Width x Bounds Height)    " + "$($_.Bounds.Width) x $($_.Bounds.Height) ($monitor_orientation)"
$monitor_type + "(Bits Per Pixel)                  " + "$($_.BitsPerPixel)"
$monitor_type + "(Working Area)                    " + "$($_.WorkingArea)"
Write-Host "TOTAL SCREEN COUNT: $screen_cnt"
}
)
write-host "This must be the size of the image in order for this program to work correctly"
}
Function Show-Error($ErrorNom){
	$Error = Get-Content ".\Data\Error\error_$ErrorNom.txt" -Raw
	Write-host "$Error"
}
write-debug "Loaded 3 Functions"
Screen-Info
Write-host "Default Path: C:\Windows\Web\Wallpaper\Windows\img0.jpg"
write-host "Leaving the space blank will cuase errors to happen and a bad result"
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Background Changer V-1.3'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$infoButton = New-Object System.Windows.Forms.Button
$infoButton.Location = New-Object System.Windows.Drawing.Point (75,140)
$infoButton.Size = New-Object System.Wiindows.Drawing.Size(75,150)
$infoButton.Text = 'Info'
$infoButton.Add_Click{
	Screen-Info
}

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Enter Path to image:'
$form.Controls.Add($label)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,60)
$labal1.Size = New-Object System.Drawing.Size(280,200)
$label1.Text = 'Default Windows Background: C:\Windows\Web\Wallpaper\Windows\img0.jpg'
$form.Controls.Add($label1)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$textBox.Text = "C:\Windows\Web\Wallpaper\Windows\img0.jpg"
$form.Controls.Add($textBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()
write-debug "Loaded and shown form"

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
	write-debug "User entered: $textBox.text"
    $value = $textBox.Text
}
if ($value -eq $null){
	Show-Error -ErrorNom "1"
	add-content -path ".\Logs\$date.log" -value "test"
}
if ($result -eq [System.Windows.Forms.DialogResult]::CANCEL)
{
	write-debug "User Cancelled Operation"
	exit
}
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe
taskkill /f /im explorer.exe
Set-WallPaper -value "$value"
taskkill /f /im explorer.exe
explorer.exe



