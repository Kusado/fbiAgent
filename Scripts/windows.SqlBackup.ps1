Param(
    [Parameter(Mandatory=$True,Position=1)]
     [string]$serviceName
  )

<#
Retuns:
0 - no backup job  found
1 - all ok
2 - something is not ok
#>

MSSQL$EGRUL
MSSQLSERVER

$instanceName = $serviceName.Replace(""


Invoke-SQL -dataSource 



function Invoke-SQL {
    param(
        [string] $dataSource = ".\SQLEXPRESS",
        [string] $database = "MasterData",
        [string] $sqlCommand = $(throw "Please specify a query.")
      )

    $connectionString = "Data Source=$dataSource; " +
            "Integrated Security=SSPI; " +
            "Initial Catalog=$database"

    $connection = new-object system.data.SqlClient.SQLConnection($connectionString)
    $command = new-object system.data.sqlclient.sqlcommand($sqlCommand,$connection)
    $connection.Open()

    $adapter = New-Object System.Data.sqlclient.sqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataSet) | Out-Null

    $connection.Close()
    $dataSet.Tables

}
# SIG # Begin signature block
# MIIIdAYJKoZIhvcNAQcCoIIIZTCCCGECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU7uR2Bq567YTOHVfoc3BE9zFN
# DfmgggZfMIIGWzCCBEOgAwIBAgITHAAAABfTJzYopHkkRwAAAAAAFzANBgkqhkiG
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
# CzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFPesysA0FD3ak4MBD3/t
# IG1vWC6cMA0GCSqGSIb3DQEBAQUABIGAOvbNB0TENQJI0iAtbzG28lMWPh0uwAEN
# 9/nTE1RCOSSxuymQUcL/8qgDbkeweMgA3J35UPO0oLG6grSiezQGVWRbFsKLa7or
# D+78T3OPKI6dlNjCrbab3YKr5yeCUdVxl3pECkh7f6qpsWtq4LdFY4xh95GV9OYz
# QhukL9UFBSw=
# SIG # End signature block
