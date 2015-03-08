# Paths first
$b64DstPath = "less.zip.b64"
$binDstPath = "less.zip"

# Read the encoded data
$dataInBase64 = get-content $b64DstPath

# Decode the base64 encoding
$decodedData =  [System.Convert]::FromBase64String($dataInBase64)

# Save the decoded data as a byte, not text
set-content -Path $binDstPath -Value $decodedData -Encoding Byte