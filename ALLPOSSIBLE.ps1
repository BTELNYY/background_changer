#Import Assembly
add-content -path ".\Logs\log.txt" -value "Importing Assembly!"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Screen]::AllScreens
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$date = Get-Date
$dir = Get-Location
$DebugPrefrence = "Continue"
write-debug "Finished Installing assembly"
$XML = [xml](Get-Content -Path "config.xml" -Encoding UTF8)
$defaultPath = $XML.Configuration.Feature | Where-Object {$_.Name -like 'defaultPath'} | Select-Object -ExpandProperty 'Value'
$useLastPath = $XML.Configuration.Feature | Where-Object {$_.Name -like 'useLastPath'} | Select-Object -ExpandProperty 'Enabled'
$fav1 = $XML.Configuration.Favorite | Where-Object {$_.Name -like 'fav1'} | Select-Object -ExpandProperty 'Value'
$fav2 = $XML.Configuration.Favorite | Where-Object {$_.Name -like 'fav2'} | Select-Object -ExpandProperty 'Value'
$fav3 = $XML.Configuration.Favorite | Where-Object {$_.Name -like 'fav3'} | Select-Object -ExpandProperty 'Value'
$bckpic = $XML.Configuration.Feature | Where-Object {$_.Name -like 'bckpic' } | Select-Object -ExpandProperty 'Value'
$bck1 = $XML.Configuration.Background | Where-Object {$_.Name -like 'bck1' } | Select-Object -ExpandProperty 'Value'
$bckpicNAME = $XML.Configuration.Background | Where-Object {$_.Name -like 'bckpicNAME' } | Select-Object -ExpandProperty 'Value'
$bck2 = $XML.Configuration.Background | Where-Object {$_.Name -like 'bck2' } | Select-Object -ExpandProperty 'Value'
$bckpic2NAME = $XML.Configuration.Background | Where-Object {$_.Name -like 'bckpic2NAME' } | Select-Object -ExpandProperty 'Value'
function Get-FileName(){
	$filepath = Get-ChildItem "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.jpg"
	write-host $filepath
	copy-item $value -Destination "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\"
	remove-item $filepath -force
	rename-item -path "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.jpg" -newname "$filepath.Name"
	write-host $filepath.Name
}
function changebck($value){
	taskkill /f /im explorer.exe
	Set-WallPaper -value "$value"
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
	taskkill /f /im explorer.exe
	Set-WallPaper -value "$value"
	taskkill /f /im explorer.exe
	explorer.exe
	taskkill /f /im powershell.exe
	powershell.exe -file gui.ps1
	write-host "$value"
	$value = $null
}
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
add-content -path ".\Logs\log.txt" -value "Loading Functions"
Screen-Info
Write-host "Default Path: $defaultPath"
write-host "Leaving the space blank will cuase errors to happen and a bad result"
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Background Changer V-1.4'
$Form.FormBorderStyle = 'Fixed3D'
$Form.MaximizeBox = $true
$form.Size = New-Object System.Drawing.Size(500,500)
$form.StartPosition = 'CenterScreen'
$WantFile = $bck2
$FileExists = Test-Path $WantFile
If ($FileExists -eq $True) {Write-Host "File Found"}
Else {Write-Host "Error: File $bck2 Not found!"}
$Picture = $bck1
$img = [System.Drawing.Image]::Fromfile($bck1)
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Size = new-object System.Drawing.Size(200,200)
$pictureBox.Location = New-Object System.Drawing.Point(0,-50)
$pictureBox.Image = $img
$picturebox.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$form.controls.add($pictureBox)
$bck1a = New-Object System.Windows.Forms.Button
$bck1a.Location = New-Object System.Drawing.Point(0,150)
$bck1a.Size = New-Object System.Drawing.Size(175,23)
$bck1a.Text = $bckpicNAME
$bck1a.Add_Click{
	changebck -value "$bck1"
}
$form.Controls.Add($bck1a)
$img1 = [System.Drawing.Image]::Fromfile($bck2)
write-host "$bck2"
$pictureBox1 = new-object Windows.Forms.PictureBox
$pictureBox1.Size = new-object System.Drawing.Size(200,200)
$pictureBox1.Location = New-Object System.Drawing.Point(280,-50)
$pictureBox1.Image = $img1
$picturebox1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
$pictureBox1.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$form.controls.add($pictureBox1)
$bck1b = New-Object System.Windows.Forms.Button
$bck1b.Location = New-Object System.Drawing.Point(300,150)
$bck1b.Size = New-Object System.Drawing.Size(175,23)
$bck1b.Text = $bckpic2NAME
$bck1b.Add_Click{
	changebck -value "$bck2"
}
$form.Controls.Add($bck1b)
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(0,235)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
write-debug "Created okButton"
#$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(0,432)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::CANCEL
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Enter Path to image:'
#$form.Controls.Add($label)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,60)
$label1.Size = New-Object System.Drawing.Size(280,20)
$label1.Text = 'Search up: whats a path windows 10 and find yours'
#$form.Controls.Add($label1)

if ($useLastPath -eq "true"){
	$value = get-content .\temp.txt -raw
	remove-item .\temp.txt
}else{ 
	$value = $defaultPath
}

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(280,20)
$textBox.Text = $value
#$form.Controls.Add($textBox)

$form.Topmost = $true
write-debug "Loaded and shown form"

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
	write-debug "User entered: $textBox.text"
    $value = $textBox.Text
	$lastValue = $value
	Add-Content -path .\temp.txt -value $value
}
if ($value -eq $null){
	Show-Error -ErrorNom "1"
	add-content -path ".\Logs\log.txt" -value "test"
}
if ($result -eq [System.Windows.Forms.DialogResult]::CANCEL)
{
	write-debug "User Cancelled Operation"
}
add-content -path ".\Logs\log.txt" -value "Added Forms and if statements"
$usedPath = $value
add-content -path ".\Logs\log.txt" -value "Forcing Background Change"
$result = $form.ShowDialog()
write-host "$value"
add-content -path ".\Logs\log.txt" -value "Scirpt Complete"




