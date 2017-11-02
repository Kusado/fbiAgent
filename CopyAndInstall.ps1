if((Get-AuthenticodeSignature .\CopyAndInstall.ps1).status -ne "Valid") {Break}

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator"))
{
        [System.Reflection.Assembly]::LoadWithPartialName(“System.Windows.Forms”)
        [Windows.Forms.MessageBox]::Show("You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!")
        Break
}

$trustedCert = get-item Cert:\LocalMachine\TrustedPublisher\126E196BD8C229879CF8A3588586F513FDFFB8AA;
$PublisherCertPath = "\\fenix\Distrib\Zabbix\fbiAgent\crt\MyCodeSignPubl.cer"


if($trustedCert -eq $null){

    Function importCert([string]$certSaveLocation) {
        $CertToImport = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $certSaveLocation
    
        $CertStoreScope = "LocalMachine"
        $CertStoreName = "TrustedPublisher"
        $CertStore = New-Object System.Security.Cryptography.X509Certificates.X509Store $CertStoreName, $CertStoreScope
    
        # Import The Targeted Certificate Into The Specified Cert Store Name Of The Specified Cert Store Scope
        $CertStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
        $CertStore.Add($CertToImport)
        $CertStore.Close()
    }

    #Does not work on older servers...
    #import-module PKI
    #Import-Certificate -FilePath $PublisherCertPath
    importCert $PublisherCertPath
}


$initialPath = "\\fenix\Distrib\Zabbix\fbiAgent\"
$path = "C:\Windows\Zabbix\"

get-process zabbix_agentd | Stop-Process -Force


Get-ChildItem -Path $path -Exclude '.*' | Remove-Item -Recurse -Force

Get-ChildItem -Path $initialPath | Copy-Item -Destination $path -Force -Recurse

Set-Location $path

.\UnInstall.ps1
.\Install.ps1

Set-Location $initialPath
# SIG # Begin signature block
# MIIIdAYJKoZIhvcNAQcCoIIIZTCCCGECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUUi1T3p22gGRlT0TXzAWex6J9
# QpagggZfMIIGWzCCBEOgAwIBAgITHAAAABfTJzYopHkkRwAAAAAAFzANBgkqhkiG
# 9w0BAQsFADBIMRUwEwYKCZImiZPyLGQBGRYFbG9jYWwxGTAXBgoJkiaJk/IsZAEZ
# FglGb3JtdWxhQkkxFDASBgNVBAMTC0Zvcm11bGEtREMzMB4XDTE3MDYyMTEwNDAw
# MloXDTE4MDYyMTEwNDAwMlowezEVMBMGCgmSJomT8ixkARkWBWxvY2FsMRkwFwYK
# CZImiZPyLGQBGRYJRm9ybXVsYUJJMRIwEAYDVQQLEwlGb3JtdWxhQkkxMzAxBgNV
# BAMMKtCQ0LHRgNCw0LzQvtCyINCY0LvRjNGPINCQ0L3QtNGA0LXQtdCy0LjRhzCB
# nzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA0XgGnLI79yeMmh0Nr7BcTh4OyARP
# 4pD/nP3/74a87olCv0t7j4quj+2fmYKOisL7dF7M2Vqd3ZiCmxz+v7RwSpD+xWb3
# jZk0qxlx2WymY4vniVAgpQIiL41eMsDAbj3BmOvHCNGBvbz/aUG3ARbtNf6I4nNG
# QE4beziw5cN4e3UCAwEAAaOCAo0wggKJMAsGA1UdDwQEAwIF4DATBgNVHSUEDDAK
# BggrBgEFBQcDAzAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMDMB0GA1UdDgQW
# BBSYQ5d1C7kfTQfRRQVt3Hv3pJ+v+TAfBgNVHSMEGDAWgBTS/OTAcnZ4J5qAC2C7
# Hw2uDwOT6TCBzgYDVR0fBIHGMIHDMIHAoIG9oIG6hoG3bGRhcDovLy9DTj1Gb3Jt
# dWxhLURDMyxDTj1zcnYtZGMwMyxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
# dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1Gb3JtdWxhQkks
# REM9bG9jYWw/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENs
# YXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MIHBBggrBgEFBQcBAQSBtDCBsTCBrgYI
# KwYBBQUHMAKGgaFsZGFwOi8vL0NOPUZvcm11bGEtREMzLENOPUFJQSxDTj1QdWJs
# aWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9u
# LERDPUZvcm11bGFCSSxEQz1sb2NhbD9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
# Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA+BgkrBgEEAYI3FQcEMTAvBicr
# BgEEAYI3FQiFgK94gc6sMIbpjzWGoYBogZCYYIEhgu61X4fo51kCAWQCAQUwMwYD
# VR0RBCwwKqAoBgorBgEEAYI3FAIDoBoMGGlhYnJhbW92QEZvcm11bGFCSS5sb2Nh
# bDANBgkqhkiG9w0BAQsFAAOCAgEAAkxdvg96StzXkX57GLEdSOdJ5PH/MAGn5b6E
# D/QCKddDugYklD8v1aa7Ga1j3XsML4geU2XhBr7BhvsbraKR4o5v3U7XqXg+pBys
# eGC+FD6ahyzoJkx94nxHymhAAf84Guwy10A/4COTiBLxWNrr7bm70dJXWymIZG85
# J9tZleaZrFEdGepA/jVZDkrcngnhNTh3FgpRRwaj9DNh5WjXODiwyyFMNRiV7Leb
# y9+b8hqPoKvegU9ZLx5rUguMkrjkA85y8ThH9wjg4MNBE+F15Bqe1Qa4iyf3tx+Q
# CB2tWtkuw+JfA6wU7ioyrKAZ66KEeS7ZITsOsFDjguEjjPBg3fgo7nxwYBTUfSd5
# uvc8b4Ln9F2U2bI+WNPhz9R7sw4HmzHnO1ORdC2XZ1ikkJfj03HdyHWEokRS30+p
# 4lBSXSV/W5UbtaCrYc3Q483K5TLNuNARaEhn7cn/H4zAlEnGXxAvKV+QjcrB1WvV
# 62/i3tgeQuWR96X4UKPLqH2jzsv3eVKSZGe2UCdpR4fMFfKYA3ibX1iFGZcKdDJm
# Cn+weIksMjYZ2qaGufKC0DxN3A/8V1MG9Tq2b1YuhZTZQyTrJtVBmPYmLvXobHtb
# yvczmCvpSzrCGFo74n1CZfZOF5KIyEKKuox6jyedcR2EwvdZaPCYRapKjSsNfWjn
# +7oDlSsxggF/MIIBewIBATBfMEgxFTATBgoJkiaJk/IsZAEZFgVsb2NhbDEZMBcG
# CgmSJomT8ixkARkWCUZvcm11bGFCSTEUMBIGA1UEAxMLRm9ybXVsYS1EQzMCExwA
# AAAX0yc2KKR5JEcAAAAAABcwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAI
# oAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIB
# CzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFEyPnYBCfZWRq3qMWW7J
# dsVcmONaMA0GCSqGSIb3DQEBAQUABIGAqy8xvuFKRNaER+5YodODXQH2STqh+XMl
# /+VZgvewaO9LCzDr7qxdSly0LfMtO8fn6KAjQI4KEVl6b17LxIzZg2ih3py+dAns
# 4D1HiDlmY979lR/3DpgAYAEauTqGj0Y61NxS3SWaoZRDyznbXv/kPEAmAg+lTn5T
# DLojaA+1iVo=
# SIG # End signature block
