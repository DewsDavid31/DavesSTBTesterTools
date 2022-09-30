Add-type -assembly System.Windows.Forms
$TopMargin = 10
$AllWidth = 600
$AllHeight = 600
$main_form = New-Object System.Windows.Forms.form
$main_form.Width = $AllWidth

$CFLabel = New-Object System.Windows.Forms.Label
$CFLabel.Text = "Select Cube/Rack"
$CFLabel.Location = New-Object System.Drawing.Point(0,10)
$CFLabel.AutoSize = $true
$CFButton = New-Object System.Windows.Forms.Button
$CFButton.Location = New-Object System.Drawing.Size($AllHeight,$TopMargin)
$CFButton.Size = New-Object System.Drawing.Size(120,23)
$CFButton.Text = "Set Cube/Rack"
$CFDrop = New-Object System.Windows.Forms.ComboBox
$CFDrop.Width = 300
$CFDrop.Items.Add("Template.config")
$CFDrop.Location = New-Object System.Drawing.point(200,10)

$DLLabel = New-Object System.Windows.Forms.Label
$DLLabel.Text = "Releases"
$DLLabel.Location = New-Object System.Drawing.Point(0,50)
$DLLabel.AutoSize = $true
$DLCheck = New-Object System.Windows.Forms.CheckedListBox
$DLCheck.Width = 150
$DLCheck.Location = New-Object System.Drawing.point(200,50)
$DLCheck.Items.Add("Release A")
$DLCheck.Items.Add("Release B")
$DLCheck.Items.Add("Release C")
$VRCheck = New-Object System.Windows.Forms.CheckedListBox
$VRCheck.Width = 150
$VRCheck.Location = New-Object System.Drawing.point(350,50)
$VRCheck.Items.Add("A1")
$VRCheck.Items.Add("B1")
$VRCheck.Items.Add("C1")
$DLButton = New-Object System.Windows.Forms.Button
$DLButton.Location = New-Object System.Drawing.Size($AllHeight,50)
$DLButton.Size = New-Object System.Drawing.Size(120,23)
$DLButton.Text = "Download"


$WTLabel = New-Object System.Windows.Forms.Label
$WTLabel.Text = "Watches"
$WTLabel.Location = New-Object System.Drawing.Point(0,150)
$WTLabel.AutoSize = $true

$WTButton = New-Object System.Windows.Forms.Button
$WTButton.Location = New-Object System.Drawing.Size($AllHeight, 100)
$WTButton.Size = New-Object System.Drawing.Size(120,23)
$WTButton.Text = "Watch Release"

$WTProg1 = New-Object System.Windows.Forms.ProgressBar
$WTProg1.Width = 40
$WTProg1.Location = New-Object System.Drawing.point(200,150)
$WTProg1.Minimum = 0
$WTProg1.Maximum = 100

$WTProg2 = New-Object System.Windows.Forms.ProgressBar
$WTProg2.Width = 40
$WTProg2.Location = New-Object System.Drawing.point(250,150)
$WTProg2.Minimum = 0
$WTProg2.Maximum = 100

$WTProg3 = New-Object System.Windows.Forms.ProgressBar
$WTProg3.Width = 40
$WTProg3.Location = New-Object System.Drawing.point(300,150)
$WTProg3.Minimum = 0
$WTProg3.Maximum = 100

$WTProg4 = New-Object System.Windows.Forms.ProgressBar
$WTProg4.Width = 40
$WTProg4.Location = New-Object System.Drawing.point(350,150)
$WTProg4.Minimum = 0
$WTProg4.Maximum = 100


$WTProg5 = New-Object System.Windows.Forms.ProgressBar
$WTProg5.Width = 40
$WTProg5.Location = New-Object System.Drawing.point(400,150)
$WTProg5.Minimum = 0
$WTProg5.Maximum = 100

$WTText = New-Object System.Windows.Forms.Label
$WTText.Text = "Watch 0"
$WTText.Location = New-Object System.Drawing.Point(200,180)
$WTText.AutoSize = $true

$BVLabel = New-Object System.Windows.Forms.Label
$BVLabel.Text = "BVT"
$BVLabel.Location = New-Object System.Drawing.Point(0,200)
$BVLabel.AutoSize = $true
$MGButton = New-Object System.Windows.Forms.Button
$MGButton.Location = New-Object System.Drawing.Size($AllHeight, 200)
$MGButton.Size = New-Object System.Drawing.Size(120,23)
$MGButton.Text = "Merge CSVs"
$BVCheck = New-Object System.Windows.Forms.ListBox
$BVCheck.Width = 300
$BVCheck.Location = New-Object System.Drawing.point(200,200)
$BVCheck.Items.Add("BVT03.csv")
$BVCheck.Items.Add("BVT02.csv")
$BVCheck.Items.Add("BVT01.csv")

$TRButton = New-Object System.Windows.Forms.Button
$TRButton.Location = New-Object System.Drawing.Size($AllHeight, 230)
$TRButton.Size = New-Object System.Drawing.Size(120,23)
$TRButton.Text = "Create BVT"

$HKLabel = New-Object System.Windows.Forms.Label
$HKLabel.Text = "Testing Macros"
$HKLabel.Location = New-Object System.Drawing.Point(0,300)
$HKLabel.AutoSize = $true

$HKButton = New-Object System.Windows.Forms.Button
$HKButton.Location = New-Object System.Drawing.Size($AllHeight,320)
$HKButton.Size = New-Object System.Drawing.Size(120,23)
$HKButton.Text = "Bind Key"

$UPButton = New-Object System.Windows.Forms.Button
$UPButton.Text = "Start Macro"
$UPButton.Location = New-Object System.Drawing.Size($AllHeight,350)
$UPButton.Size = New-Object System.Drawing.Size(120,23)


$HLLabel = New-Object System.Windows.Forms.Label
$HLLabel.Text = "Keys"
$HLLabel.Location = New-Object System.Drawing.Point(200,310)
$HLLabel.AutoSize = $true

$HKList = New-Object System.Windows.Forms.ListBox
$HKList.Width = 150
$HKList.Location = New-Object System.Drawing.point(200,340)
$HKList.Items.Add("+")
$HKList.Items.Add("~")
$HKList.Items.Add("END")

$SLLabel = New-Object System.Windows.Forms.Label
$SLLabel.Text = "Scripts"
$SLLabel.Location = New-Object System.Drawing.Point(350,310)
$SLLabel.AutoSize = $true

$SCList = New-Object System.Windows.Forms.ListBox
$SCList.Width = 150
$SCList.Location = New-Object System.Drawing.point(350,340)
$SCList.Items.Add("LockComputerWithPgUp.ahk")
$SCList.Items.Add("AutoPasser.ahk")


$Selected = New-Object System.Windows.Forms.Label
$Selected.Text = "Nothing selected yet"
$Selected.Location = New-Object System.Drawing.Point(200,500)
$Selected.AutoSize = $true






$main_form.Height = $AllHeight
$main_form.AutoSize = $true
$main_form.Controls.Add($CFButton)
$main_form.Controls.Add($CFDrop)
$main_form.Controls.Add($CFLabel)
$main_form.Controls.Add($DLButton)
$main_form.Controls.Add($DLLabel)
$main_form.Controls.Add($DLCheck)
$main_form.Controls.Add($VRCheck)
$main_form.Controls.Add($DLButton)
$main_form.Controls.Add($DLLabel)
$main_form.Controls.Add($HKButton)
$main_form.Controls.Add($UPButton)
$main_form.Controls.Add($HKLabel)
$main_form.Controls.Add($WTButton)
$main_form.Controls.Add($WTLabel)
$main_form.Controls.Add($WTText)
$main_form.Controls.Add($WTProg1)
$main_form.Controls.Add($WTProg2)
$main_form.Controls.Add($WTProg3)
$main_form.Controls.Add($WTProg4)
$main_form.Controls.Add($WTProg5)
$main_form.Controls.Add($WTButton)
$main_form.Controls.Add($WTLabel)
$main_form.Controls.Add($MGButton)
$main_form.Controls.Add($SCList)
$main_form.Controls.Add($SLLabel)
$main_form.Controls.Add($HLLabel)
$main_form.Controls.Add($HkList)
$main_form.Controls.Add($BVCheck)
$main_form.Controls.Add($BVLabel)
$main_form.Controls.Add($TRButton)
$main_form.Controls.Add($Selected)

$CFButton.Add_Click(

{
}
)
$DLButton.Add_Click(

{
 for ($i = 0; $i - ($VRCheck.Items.Count); $i++)
  {
    if ($VRCheck.GetItemChecked($i))
    { 
    $a = $VRCheck.Items[$i].ToString();
     for ($j = 0; $j - ($VRCheck.Items.Count); $j++)
    {
        if ($DLCheck.GetItemChecked($j))
        { 
            $s = $s + $DLCheck.Items[$j].ToString();
            $s = $s + $a + ", "
        }
    }
    }
  }
  $Selected.Text = "Downloading: " + $s
}
)
$HKButton.Add_Click(

{
for ($i = 0; $i - ($HKList.Items.Count); $i++)
  {
    if ($HKList.GetItemChecked($i))
    { 
    $a = $HKList.Items[$i].ToString() + "::";
     for ($j = 0; $j - ($SCList.Items.Count); $j++)
    {
        if ($SCList.GetItemChecked($j))
        { 
            $s = ".\MACRO\" + $SCList.Items[$j].ToString()
            (Get-Content $s -Raw) -Replace [regex]::Escape("$a"),$CHText.Value | Set-Content $s
            $HKList.Items[$i] = $a
            start $s
        }
    }
    }
  }
  $Selected.Text = $s
}
)
$UPButton.Add_Click(

{
   
}
)

$WTButton.Add_Click(

{
$WTText.Text = "AA1"
$WTProg1.Value += 10
}
)
$MGButton.Add_Click(

{
    $csvInmerged = ".\CSV\merged.csv"
    $csvIn = ".\CSV\*.csv"
    copy $csvIn  $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('sep=,'),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('sep=;'),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape(';'),[regex]::Escape(',') | Set-Content $csvInmerged
    Import-Csv $csvInmerged -Delimiter ',' -Header "time","unused", "deviceName","unused2", "scenarioName", "unused3","status" | sort deviceName,scenarioName -Unique | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape(';'),[regex]::Escape(',') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('@{'),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('}'),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('time='),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('unused='),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('deviceName='),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('unused2='),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('scenarioName='),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('unused3='),[regex]::Escape('') | Set-Content $csvInmerged
    (Get-Content $csvInmerged -Raw) -Replace [regex]::Escape('status='),[regex]::Escape('') | Set-Content $csvInmerged
}
)
$TRButton.Add_Click(

{
.\BVTConverter.ps1
}
)


$main_form.ShowDialog()


