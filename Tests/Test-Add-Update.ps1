
<#
.Synopsis
	Add with the same _id and Add -Update.
#>

Import-Module Mdbc
$collection = Connect-Mdbc . test test -NewCollection

# New document
$document = New-MdbcData
$document._id = 12345
$document.Name = 'Hello'

# Add the document
$document | Add-MdbcData $collection

# Add again with the same _id and another Name
$document.Name = 'World'
$document | Add-MdbcData $collection

# Test: Name is still 'Hello', 'World' is not added or saved
$data = @(Get-MdbcData $collection)
if ($data.Count -ne 1) { throw }
if ($data[0].Name -ne 'Hello') { throw }

# Add again, this time with the Update switch
$document.Name = 'World'
$document | Add-MdbcData $collection -Update

# Test: Name is 'World', the document is updated
$data = @(Get-MdbcData $collection)
if ($data.Count -ne 1) { throw }
if ($data[0].Name -ne 'World') { throw }
