param($url)

Write-Host "Fetching from url $url"

try {
    $response = Invoke-WebRequest -Uri $url -UseBasicParsing -MaximumRedirection 5
    $content = $response.Content

    # Extract page title
    if ($content -match '<title[^>]*>([^<]+?)\s*\|\s*Microsoft Learn</title>') {
        $title = $Matches[1].Trim()
    } else {
        $title = "No title found"
    }

    $title
} catch {
    "Error fetching from ${url}: $($_.Exception.Message)"
}
