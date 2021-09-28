# source: https://www.reddit.com/r/PowerShell/comments/905w3d/comment/e2obff2/?utm_source=share&utm_medium=web2x&context=3

$pfxPassword = Read-Host -Prompt "Enter PFX password, leave empty if no password used" -MaskInput

$PfxFilePath = "C:\path-to-cert\cert.pfx"

$pfxFile = Get-ChildItem $PfxFilePath

$OldCertCollection = [Security.Cryptography.X509Certificates.X509Certificate2Collection]::new()
$ExportableKeyStorageFlag = [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable
$OldCertCollection.Import($PfxFilePath, $pfxPassword, $ExportableKeyStorageFlag)

$OldCertCollection

$NewCertCollection = [Security.Cryptography.X509Certificates.X509Certificate2Collection]::new()


# to understand the correct order user: certutil -dump .\mycert.pfx
$NewCertCollection.Add($OldCertCollection[1])
$NewCertCollection.Add($OldCertCollection[0])
$NewCertCollection.Add($OldCertCollection[2])

$newPfxPassword = Read-Host -Prompt "Enter new PFX password" -MaskInput

$newPfxPath = $pfxFile.DirectoryName + "\" + $pfxFile.BaseName + "-CORRECT_CHAIN.pfx"

Set-Content -Path $newPfxPath -Value $NewCertCollection.Export("pfx", $newPfxPassword) -AsByteStream