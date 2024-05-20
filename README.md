# Power BI - List Workspaces With Expanded Users
This script iterates through all Power BI Premium workspaces and extracts individual user metadata.

*Requires an authenticated user principal who is a [Fabric Service Admin](https://learn.microsoft.com/en-us/power-bi/admin/service-admin-role).

## Instructions
Make sure you have the Powershell cmdlet [MicrosoftPowerBIMgmt](https://learn.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps) installed.

Within a PowerShell terminal, navigate to the project directory and execute `& .\run.ps1`.

## Notes
The [Admin - Groups GetGroupsAsAdmin](https://learn.microsoft.com/en-us/rest/api/power-bi/admin/groups-get-groups-as-adminn) endpoint has a throttle limitation of 50 requests per hour or 15 requests per minute. This call will also time out after 30 seconds to prevent adverse effect on the Power BI service.

## Power BI REST APIs Reference
[Admin - Groups GetGroupsAsAdmin](https://learn.microsoft.com/en-us/rest/api/power-bi/admin/groups-get-groups-as-admin)

## Credit
Derived from Rui Romano's [PBIMonitor](https://github.com/RuiRomano/pbimonitor).