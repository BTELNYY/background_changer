<#
NOTES:
	This script is used to change the background of the current user.
	This Script Closes all explorer Windows meaning that Properties, File Explorer, Shutdown Prompts.
	This Does Not Close Office or anything else. 
CREDITS:
	Bohdan Telnyy
USAGE: 
	Run the batch script and let the window open there you must enter a path and click OK
CONFIG:
	The Scripts Config is stored in a XML File.
	The File is called config.xml and must be stored in the same directory as the script file.
SAFETY:
	DO NOT REMOVE FILES FROM THE GIVEN DIRECTORY.
	DO NOT CHANGE THE CONFIG FILE UNLESS YOU KNOW WHAT YOUR DOING
	THIS SCRIPT DOESNT HAVE CRASH HANDLING SO IT WILL ATTEMP TO CONTINUE.
	THE CONFIG FILE CAN BE REMOVED AND THE SCRIPTS MAJOR FUNCTION WILL WORK BUT NO DEFAULT PATH WILL BE SPECIFEIED AND NO GUI BACKGROUND PICTURE WILL NOT BE SHOWN, THIS WILL NOT AFFECT THE DESKTOP BACKGROUND.
COPYRIGHT:
	You can modify the code but please keep my name in the credits section
	you may add your name there as well
#>
#Import Assembly
$shell = New-Object -ComObject "Shell.Application"
add-content -path ".\Logs\log.txt" -value "Importing Assembly!"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Screen]::AllScreens
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()
[CmdletBinding()]
# Set Varaibles
$date = Get-Date
$dir = Get-Location
$DebugPrefrence = "Continue"
write-debug "Finished Installing assembly"
$XML = [XML](Get-Content -Path "config.xml" -Encoding UTF8)
$defaultPath = $XML.Configuration.Feature | Where-Object {$_.Name -like 'defaultPath'} | Select-Object -ExpandProperty 'Value'
$useLastPath = $XML.Configuration.Feature | Where-Object {$_.Name -like 'useLastPath'} | Select-Object -ExpandProperty 'Enabled'
$fav1 = $XML.Configuration.Favorite | Where-Object {$_.Name -like 'fav1'} | Select-Object -ExpandProperty 'Value'
$fav2 = $XML.Configuration.Favorite | Where-Object {$_.Name -like 'fav2'} | Select-Object -ExpandProperty 'Value'
$fav3 = $XML.Configuration.Favorite | Where-Object {$_.Name -like 'fav3'} | Select-Object -ExpandProperty 'Value'
$bckpic = $XML.Configuration.Feature | Where-Object {$_.Name -like 'bckpic' } | Select-Object -ExpandProperty 'Value'
$minimizeall = $XML.Configuration.Feature | Where-Object {$_.Name -like 'minimizeAll'} | Select-Object -ExpandProperty 'Value'
$checkpath = $XML.Configuration.Feature | Where-Object {$_.Name -like 'checkpath'} | Select-Object -ExpandProperty 'Value'
$version = $XML.Configuration.Version | Where-Object {$_.Name -like 'Version'} | Select-Object -ExpandProperty 'Value'
$IconFile1 = $XML.Configuration.Feature | Where-Object {$_.Name -like 'IconFile'} | Select-Object -ExpandProperty 'Value'
$NullPath = $XML.Configuration.Feature | Where-Object {$_.Name -like 'NullPath'} | Select-OBject -ExpandProperty "Value"
$openfile = "false"
$host.ui.RawUI.WindowTitle = "BTELNYY's Background Changer v $version"
# Minimize ALL other Windows
$shell.minimizeall()
# Functions
Function Progress-Bar(){
	#requires -version 3.0

#demo winform status box with a progress bar control

#path to report on
$path = "C:\"

#this line may not be necessary
#[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
Add-Type -assembly System.Windows.Forms

#title for the winform
$Title = "Directory Usage Analysis: $Path"
#winform dimensions
$height=100
$width=400
#winform background color
$color = "Black"

#create the form
$form1 = New-Object System.Windows.Forms.Form
$form1.Text = $title
$form1.Height = $height
$form1.Width = $width
$form1.BackColor = $color

$form1.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
#display center screen
$form1.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

# create label
$label1 = New-Object system.Windows.Forms.Label
$label1.Text = "not started"
$label1.Left=5
$label1.Top= 10
$label1.Width= $width - 20
#adjusted height to accommodate progress bar
$label1.Height=15
$label1.Font= "Verdana"
$Label1.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#FFFFF")
#optional to show border
#$label1.BorderStyle=1

#add the label to the form
$form1.controls.add($label1)

#One change I made from my earlier example was to adjust the height of the label control. Now to create and add the ProgressBar control.

$progressBar1 = New-Object System.Windows.Forms.ProgressBar
$progressBar1.Name = 'progressBar1'
$progressBar1.Value = 0
$progressBar1.Style="Continuous"

#Setting the style to "Continuous" will give us a nice looking and smooth progress bar. Next, I need to create a drawing object and use that to give the progress bar its size.

$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = $width - 40
$System_Drawing_Size.Height = 20
$progressBar1.Size = $System_Drawing_Size

#Using the values for the label and some trial and error, I specify where the progress bar should start on the form.

$progressBar1.Left = 5
$progressBar1.Top = 40
#Finally, like the other controls, the progress bar needs to be added to the form.
$form1.Controls.Add($progressBar1)
#Now I can show the form and start the main part of my PowerShell script.
$form1.Show()| out-null

#give the form focus
$form1.Focus() | out-null

#update the form
$label1.text="Preparing to analyze $path"
$form1.Refresh()

start-sleep -Seconds 1

#run code and update the status form

#get top level folders
$top = Get-ChildItem -Path $path -Directory

#initialize a counter
$i=0

 

#As I've been doing all along, I'll use ForEach to process each item, calculate my percentage complete and use that value for the progress bar.

foreach ($folder in $top) {

#calculate percentage
$i++
[int]$pct = ($i/$top.count)*100
#update the progress bar
$progressbar1.Value = $pct

$label1.text="Measuring size: $($folder.Name)"
$form1.Refresh()

start-sleep -Milliseconds 100
$stats = Get-ChildItem -path $folder -Recurse -File |
Measure-Object -Property Length -Sum -Average
[pscustomobject]@{
Path=$folder.Name
Files = $stats.count
SizeKB = [math]::Round($stats.sum/1KB,2)
Avg = [math]::Round($stats.average,2)
}
} #foreach

#At the end of the script I clean up after myself and close the form.

$form1.Close()
}
Function Set-Error($ErrorID) {
$Error1                           = New-Object system.Windows.Forms.Form
$Error1.ClientSize                = New-Object System.Drawing.Point(518,130)
$Error1.text                      = "Error"
$Error1.FormBorderStyle           = 'Fixed3D'
$Error1.TopMost                   = $false
$Error1.MaximizeBox               = $false
#$Error1.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$ErrorPicture                    = New-Object system.Windows.Forms.PictureBox
$ErrorPicture.width              = 71
$ErrorPicture.height             = 63
$ErrorPicture.location           = New-Object System.Drawing.Point(0,15)
$ErrorPicture.imageLocation      = "Data\Image\4.jpg"
$ErrorPicture.SizeMode           = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$Close                           = New-Object system.Windows.Forms.Button
$Close.text                      = "Close"
$Close.width                     = 55
$Close.height                    = 25
$Close.location                  = New-Object System.Drawing.Point(465,105)
$Close.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Close.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("")
$Error1.CancelButton             = $Close
$Close.Anchor                    = 'right,bottom'

$Label                           = New-Object system.Windows.Forms.Label
$Label.text                      = "Something Went Wrong:"
$Label.AutoSize                  = $true
$Label.width                     = 50
$Label.height                    = 10
$Label.location                  = New-Object System.Drawing.Point(106,20)
$Label.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "at: $ErrorID"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(127,50)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Test"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(147,50)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Error1.Controls.Add 		     = $Label2
$ErrorProvider1                  = New-Object system.Windows.Forms.ErrorProvider

$Error1.controls.AddRange(@($ErrorPicture,$Close,$Label,$Label1,$label2))
$Error1.ShowDialog()
}
function Set-ConsoleIcon {
  Param(
    [parameter(Mandatory = $true)] [string] $IconFile
  )

  [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') | Out-Null

  # Verify the file exists
  if ([System.IO.File]::Exists($iconFile) -eq $true) {
    $ch = Invoke-Win32 'kernel32' ([IntPtr]) 'GetConsoleWindow'
    $i = 0;
    $size = 16;
    while ($i -ne 4) {
      $ico = New-Object System.Drawing.Icon($iconFile, $size, $size)
      if ($ico -ne $null) {
        Send-Message $ch 0x80 $i $ico.Handle | Out-Null
      }
      if ($i -eq 4) {
        break
      }
      $i += 1
      $size += 16
    }
  }
  else {
    Write-Host 'Icon file not found' -ForegroundColor 'Red'
  }
}
Set-ConsoleIcon -iconfile $iconfile1
function Read-DAT($file) {
	# read the binary data as byte array
	$bytes = [System.IO.File]::ReadAllBytes("$file")
	# convert to ASCII string
	$text = [System.Text.Encoding]::ASCII.GetString($bytes)
   
	# replace the CRLF to LF
	$text = $text -replace "`r`n", "`n"
   
	# convert back to byte array
	$bytes = [System.Text.Encoding]::ASCII.GetBytes($text)
	# show the results
	write-host "Selected FIle: $file"
	write-host "$bytes"
	write-host "$text"
}
function Random-Name(){
	# Create A Random ID
	# This can be used for creating a Random Name consisting of Letters and Numbers
	# like XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
	# RETURNS THE RANDOM VALUE
	$r1 = Get-Random 10
	$r2 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r3 = Get-Random 10
	$r4 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r5 = Get-Random 10
	$r6 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r7 = Get-Random 10
	$r8 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r9 = Get-Random 10
	$r10 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r11 = Get-Random 10
	$r12 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r13 = Get-Random 10
	$r14 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
    $r15 = Get-Random 10
    $r16 = Get-Random 10
	$r17 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r18 = Get-Random 10
	$r19 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r20 = Get-Random 10
	$r21 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r22 = Get-Random 10
	$r23 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r24 = Get-Random 10
	$r25 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r26 = Get-Random 10
	$r27 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r28 = Get-Random 10
	$r29 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" | Get-Random
	$r30 = Get-Random 10
	$RandomName = "$r1$r2$r3$r4$r5-$r6$r7$r8$r9$r10-$r11$r12$r13$r14$r15-$r16$r17$r18$r19$r20-$r21$r22$r23$r24$r25-$r26$r27$r28$r29$r30"
	return $RandomName
}
Function OpenFile(){
	# Creates a Explorer Open File Dialog
	# RETURNS FILTERED PATH
	$myFile = "C:\Projects\Scripts\any.txt"
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
	$OpenFileDialog.InitialDirectory = Split-Path $myFile -Parent 
	$OpenFileDialog.FileName = Split-path $myfile -leaf
	$OpenFileDialog.ShowDialog() | Out-Null
	return $OpenFileDialog.FileName
}
Random-Name
function Get-FileName(){
	# Getting The Cached Background's Name.
	#This is not used.
	$filepath = Get-ChildItem "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.jpg"
	write-host $filepath
	copy-item $value -Destination "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\"
	remove-item $filepath -force
	rename-item -path "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Themes\CachedFiles\*.jpg" -newname "$filepath.Name"
	write-host $filepath.Name
}
Function Set-WallPaper($Value){
	# The Main Function of this file. 
	# Used in changing the background.
 	Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
	# There can be a start sleep here but since there are many of these its not needed
 	rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True

}
Function Screen-Info(){
	# This function is used to get Screen Information.
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
Write-Host "Total Screens  : $screen_cnt"
}
)
}
Function Show-Error($ErrorNom){
	# Error Handling
	# Usage: Show-Error -ErrorNom "number"
	# Located in .\Data\Error\error_<number>.txt
	# Too make a error just make a error message in a text file and set a IF to run this function
	$Error1 = Get-Content ".\Data\Error\error_$ErrorNom.txt" -Raw
	Write-host "$Error1"
}
write-debug "Loaded Functions"
add-content -path ".\Logs\log.txt" -value "Loading Functions"
Screen-Info
#DEBUG CODE
Write-host "Default Path: $defaultPath"
#END OF DEBUG
# The Actual Form 
write-host "Leaving the space blank will cuase errors to happen and a bad result"
$form = New-Object System.Windows.Forms.Form
$form.Text = "BBC v $version"
$Form.FormBorderStyle = 'Fixed3D'
$Form.MaximizeBox = $false
$form.Size = New-Object System.Drawing.Size(325,300)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(0,235)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
write-debug "Created okButton"
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(80,235)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::CANCEL
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please Enter Path to image:'
$form.Controls.Add($label)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,60)
$label1.Size = New-Object System.Drawing.Size(280,20)
$label1.Text = 'Search up: whats a path windows 10 and find yours'
#$form.Controls.Add($label1)

# Another button to open a open file dialog.
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(160,235)
$button.Size = New-Object System.Drawing.Size(75,23)
$button.Text = 'Open File'
$button.Add_Click{
	$openfile = "true"
	OpenFile
	write-host $OpenFileDialog.FileName
}
# Change $button.Enabled = $false to $button.Enabled = $true to enable it.
# this doesnt work well 
# it can be used to find the path of the requested file.
$button.Enabled = $false
$form.Controls.Add($button)

# Creates a text box.
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(280,20)
$textBox.Text = $defaultPath
$form.Controls.Add($textBox)

# TIleWallpaper Option
$Checkbox = New-Object System.Windows.Forms.Checkbox
$Checkbox.Location = New-Object System.Drawing.Point(10,60)
$Checkbox.Size = New-Object System.Drawing.Size(280,20)
$Checkbox.Text = "Tile Wallpaper?"
$form.Controls.Add($Checkbox)
# Picture Code!
# this can be modified in config.xml
$Picture = (get-item (".\bck.jpg"))
$img = [System.Drawing.Image]::Fromfile($bckpic)
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Size = new-object System.Drawing.Size(400,400)
$pictureBox.Location = New-Object System.Drawing.Point(0,-40)
$pictureBox.Image = $img
$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$form.controls.add($pictureBox)

# This makes the window go on top.
$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()
write-debug "Loaded and shown form"

# IF Statements!
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
	if($openfile -eq "true"){
		OpenFile
		$value = $FilteredFileName
	}
	elseif($button.Enabled -eq $false){
		$value = $textBox.text
	}
	elseif($openfile -eq $false){
		$value = $textBox.Text
	}
}

$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(10,100)
$textBox1.Size = New-Object System.Drawing.Size(280,20)
$textBox1.Text = "Enter Pattern Value(Number)"
$form.Controls.Add($textBox1)
# More IF statements!
if ($value -eq $null){
	$value = $nullPath
	Set-Error -ErrorID "Bad Path: $value"
	add-content -path ".\Logs\log.txt" -value "test"
}
if ($result -eq [System.Windows.Forms.DialogResult]::CANCEL)
{
	$shell.undominimizeall()
	write-debug "User Cancelled Operation"
	break
	exit -1
}
add-content -path ".\Logs\log.txt" -value "Added Forms and if statements"
$usedPath = "$value"
add-content -path ".\Logs\log.txt" -value "Forcing Background Change"
write-host "$value"
$testpath = Test-Path -path $value -PathType leaf
if ($checkpath -eq "true" -and $testpath -eq $false){
	Set-Error -ErrorID "Unable To find File, FILE_NOT_FOUND"
	powershell.exe -file "backgroundchange.ps1" -noprofile -ExecutionPolicy Bypass
} else {
	write-host 'Path checking is disabled, path isnt checked'
}
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(160,235)
$button.Size = New-Object System.Drawing.Size(75,23)
$button.Text = 'Open File'
$button.Add_Click{
	$openfile = $true
	OpenFile
	$value = $openfileDialog.FileName
	.\Data\Error\INFO_NOT_FUNCTION.vbs
}
$form.Controls.Add($button)
Write-host $value
if($button.Enabled -eq $false){
	$value = $textBox.Text
}
if($Checkbox.Checked -eq $true){
	Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name TileWallpaper -value 1
}else{
	Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name TileWallpaper -value 0
}
# Actually Changing the Background.
stop-process -name "explorer.exe"
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
Set-WallPaper-Whole
powershell.exe -file gui.ps1
write-host "$value"
# Change the window title
$host.ui.RawUI.WindowTitle = "BTELNYY's Background Changer v $version DONE"
# UNminimize everything 
$shell.undominimizeall()
# A toast script
powershell.exe -file ".\toast\toast-script.ps1"
# Chnages the Value or Path to null for next use
$value = $null
# Logging
add-content -path ".\Logs\log.txt" -value "Scirpt Complete"




