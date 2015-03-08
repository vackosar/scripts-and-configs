# Set up paths
$binSrcPath = "C:\Program Files (x86)\Notepad++\notepad++.exe"
$b64DstPath = "C:\temp\notepad++.exe.b64"

# Read the source binary as byte array
$binData = Get-Content -Path $binSrcPath -Encoding Byte

# Convert the bytes into a base64 encoded form
$base64 = [System.Convert]::ToBase64String($binData)

# Save the encoded data
set-content $b64DstPath $base64