param($Context)

$urls = @(
    "https://learn.microsoft.com/azure/azure-functions/durable/durable-functions-overview",
    "https://learn.microsoft.com/azure/azure-functions/durable/durable-task-scheduler/durable-task-scheduler",
    "https://learn.microsoft.com/azure/azure-functions/functions-scenarios",
    "https://learn.microsoft.com/azure/azure-functions/functions-create-ai-enabled-apps"
)

# Fan out: run fetching tasks in parallel
$parallelTasks = @()
foreach ($url in $urls) {
    $parallelTasks += Invoke-DurableActivity -FunctionName 'FetchTitle' -Input $url -NoWait
}

# Fan in: wait for all parallel tasks to complete
$results = Wait-ActivityFunction -Task $parallelTasks

# Return fetched titles as a formatted string
$output = $results -join "; "
$output
