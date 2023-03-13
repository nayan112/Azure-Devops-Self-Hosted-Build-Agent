# AzureDevopsBuildAgentStatus
When a project has multiple build servers and agents and we need to keep track of status of agents, we can utilize azure devops rest api as in d 

Steps:

>>First you have to get the Pool details under which the build agent is registered/configured. Run the below request to get the results

https://dev.azure.com/{replace organisation}/_apis/distributedtask/pools?api-version=5.1

Note the ‘id’ value which is actually PoolId.

>> Now using this Pool Id we will find all the build agent Ids registered under this Pool. Run the request

https://dev.azure.com/{organisation}/_apis/distributedtask/pools/{PoolId}/agents?api-version=5.1

Now ‘id’ value is agentid. You can see the status value is also shown here. But we will run request specifically for the AgentId to get the details.

>> Now using the AgentId you can get the status of the agent. Run the below request

https://dev.azure.com/{organisation}/_apis/distributedtask/pools/{PoolId}/agents?agentid={AgentId}api-version=5.1

 

This way you can get the status of the build agent which can be monitored by scheduling a PowerShell Runbook using Azure Automation.
