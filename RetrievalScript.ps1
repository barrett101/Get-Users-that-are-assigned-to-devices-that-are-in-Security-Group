#Importing of Modules Required
Connect-MGGraph
Install-Module Microsoft.Graph -Scope AllUsers
Import-Module Microsoft.Graph.DeviceManagement

#Enter the Group ID in the below variable
$GroupID = ""

$GroupMembers = Get-MgGroupMember -GroupId $groupID -all
Foreach ($m in $groupmembers)
{
	$DeviceName = $m.AdditionalProperties["displayName"]
	$DeviceUser = $(Get-MgDeviceManagementManagedDevice -Filter "AzureAdDeviceId eq '$($m.AdditionalProperties["deviceId"])'").UserPrincipalName
	$Export = [pscustomobject]@{
		'DeviceName' = $DeviceName;
		'DeviceUser' = $DeviceUser
	}
	$Export | Export-CSV -Path C:\temp\export.csv -append
	$export = $null
	$deviceName = $null
	$DeviceUser = $null
}
