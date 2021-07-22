$cd = Split-Path $script:MyInvocation.MyCommand.Path
$newline = [System.Environment]::NewLine
$DebugPreference = "Continue"
Function OpenFile(){
        # Creates a Explorer Open File Dialog
        # RETURNS FILTERED PATH
        $myFile = "$cd"
        [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
        $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
        $OpenFileDialog.InitialDirectory = Split-Path $myFile -Parent 
        $OpenFileDialog.FileName = Split-path $myfile -leaf
        $OpenFileDialog.ShowDialog() | Out-Null
        $TextBox1.Text = $OpenFileDialog.FileName
        
}
Function Set-WallPaper($Value){
	# The Main Function of this file. 
	# Used in changing the background.
 	Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
	# There can be a start sleep here but since there are many of these its not needed
 	rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True

}

<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(291,79)
$Form.text                       = "Background Changer"
$Form.TopMost                    = $false
$Form.FormBorderStyle           = 'Fixed3D'
$Form.maximizeBox               = $false

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Go"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(169,49)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button1.Add_Click{
    $value = $TextBox1.Text
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

}

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Cancel"
$Button2.width                   = 60
$Button2.height                  = 30
$Button2.location                = New-Object System.Drawing.Point(229,49)
$Button2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button2.Add_Click{
    $Form.Close()
}

$Button3                         = New-Object system.Windows.Forms.Button
$Button3.text                    = "Open File "
$Button3.width                   = 79
$Button3.height                  = 30
$Button3.location                = New-Object System.Drawing.Point(0,48)
$Button3.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button3.Add_CLick{
    OpenFile 
    $Form.Refresh()
}

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.ReadOnly = $true
$TextBox1.width                  = 288
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(1,28)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = ""
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(-9,-11)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Background Changer v 1.6.1 FORK: EZ"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(6,6)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button4                         = New-Object system.Windows.Forms.Button
$Button4.text                    = "Help"
$Button4.width                   = 60
$Button4.height                  = 30
$Button4.location                = New-Object System.Drawing.Point(85,48)
$Button4.Add_Click{
    write-debug "USAGE $newline Click Open File and Select a picture file. Not doing so will result in a black background! $newline Once Your Ready Click go to continue."
}

$Form.controls.AddRange(@($Button1,$Button2,$Button3,$TextBox1,$Label1,$Label2,$Button4))
$Form.ShowDialog()