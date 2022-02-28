$token = Read-Host -Prompt "Enter your API account token now"
##$token = "" ##Token Hardcode
$bearer = "Bearer",$token
$url = "https://webapi.teamviewer.com/api/v1/devices";
$contentType = "application/json"
$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$header.Add("authorization", $bearer)


Import-Csv .\tvDevices.csv | ForEach-Object {
    Write-Host " ADDING DEVICE :: $($_.alias) : $($_.device_id) : $($_.remotecontrol_id) : $($_.teamviewer_id)"
    if($($_.alias) -and $($_.device_id) -and $($_.remotecontrol_id) -and $($_.teamviewer_id)){
        $data = @{        
            alias = $($_.alias);
            groupid = "";
            device_id = $($_.device_id);
            remotecontrol_id = $($_.remotecontrol_id);
            teamviewer_id = $($_.teamviewer_id);
            password = "";
            policy_id = "inherit"
        };
        $json = $data | ConvertTo-Json;
        
        $response = Invoke-RestMethod -Method POST -Uri $url -ContentType $contentType -Headers $header -Body $json;
        Write-Host $response
        Start-Sleep -s 2 ##Be polite
    }
}
