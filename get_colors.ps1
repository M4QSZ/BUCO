Add-Type -AssemblyName System.Drawing
$img = New-Object System.Drawing.Bitmap("C:\Users\Miguel\Documents\flutter\BUCO\BUCO\BUCO 2.png")
$colors = @{}
for($x=0; $x -lt $img.Width; $x+=50) {
    for($y=0; $y -lt $img.Height; $y+=50) {
        $c = $img.GetPixel($x, $y)
        $hex = "#{0:X2}{1:X2}{2:X2}" -f $c.R, $c.G, $c.B
        if($colors.ContainsKey($hex)) {
            $colors[$hex]++
        } else {
            $colors[$hex] = 1
        }
    }
}
$colors.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 5
