$user = ''
$pass = ''
$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($user, $secpasswd)
$agentStatus = Invoke-RestMethod 'https://dev.azure.com/{replace organisation}/_apis/distributedtask/pools/<poolid>/agents/<agentid>' -Credential $credential
$body = "Build agent : " + $agentStatus.name + "   Status : " + $agentStatus.status
# Write-Output "The name of build agent is : " $agentStatus.name
# Write-Output "The Status of build agent is : " $agentStatus.status

## Define the Send-MailMessage parameters
$mailParams = @{
    SmtpServer                 = ''
    Port                       = '25' # '587' # or '25' if not using TLS
    UseSSL                     = $false ## or not if using non-TLS
    Credential                 = $credential
    From                       = ''
    To                         = ''
    Subject                    = "Build agent status - $(Get-Date -Format g)"
    Body                       = $body
    DeliveryNotificationOption = 'OnFailure', 'OnSuccess'
}

## Send the message
Send-MailMessage @mailParams
