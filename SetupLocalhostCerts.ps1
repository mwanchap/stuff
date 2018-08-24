#check that the cert doesn't already exist
$currentCert = (Get-Childitem Cert:\CurrentUser\Root\ | where Subject -eq CN=*.localhost.com)

if($currentCert -ne $null)
{
    Write-Error "Root localhost cert is already installed.  Open Certificate management and delete it, then re-run this script"
    return;
}

$domain = "*.localhost.com", "localhost"
Write-Host "Creating self-signed cert for $domain"
$cert = New-SelfSignedCertificate -DnsName $domain -CertStoreLocation "cert:\LocalMachine\My" -NotAfter (Get-Date).AddYears(5)
$thumb = $cert.GetCertHashString()

Write-Host "Deleting existing cert bindings used by IIS Express"

For ($i=44300; $i -le 44399; $i++) {
    # silence the success output spam with  & { } 1 > $null
    & { netsh http delete sslcert ipport=0.0.0.0:$i } 1 > $null
}

Write-Host "Adding bindings for new self-signed cert to be used by IIS Express"
For ($i=44300; $i -le 44399; $i++) {
    # I have no idea what the magic guid is
    & { netsh http add sslcert ipport=0.0.0.0:$i certhash=$thumb appid=`{214124cd-d05b-4309-9af9-9caa44b2b74a`} } 1 > $null
}

Write-Host "Adding self-signed cert to root cert authority so it's always trusted"
$StoreScope = 'LocalMachine'
$StoreName = 'root'
$Store = New-Object  -TypeName System.Security.Cryptography.X509Certificates.X509Store  -ArgumentList $StoreName, $StoreScope
$Store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
$Store.Add($cert)
$Store.Close()
Write-Host "Completed self-signed cert setup"
