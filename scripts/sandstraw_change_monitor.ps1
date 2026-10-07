param(
    [string]$RepoRoot = ".",
    [string]$StatePath = ".sandstraw/state.json"
)

$ErrorActionPreference = "Stop"

function Get-SandstrawState {
    param([string]$Path)

    if (-not (Test-Path $Path)) {
        return @{}
    }

    try {
        $json = Get-Content -Raw -Path $Path | ConvertFrom-Json -Depth 20
        if ($null -eq $json) { return @{} }
        return $json
    }
    catch {
        return @{}
    }
}

function Get-GitChangedFiles {
    param([string]$Root)

    $git = Get-Command git -ErrorAction SilentlyContinue
    if ($null -eq $git) {
        return @()
    }

    $result = & git -C $Root status --porcelain --untracked-files=all 2>$null
    if ($LASTEXITCODE -ne 0) { return @() }

    $files = @()
    foreach ($line in $result) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $relative = $line.Substring(3).Trim()
        if ($relative.Contains(" -> ")) {
            $relative = ($relative.Split(" -> ") | Select-Object -Last 1)
        }
        if (-not [string]::IsNullOrWhiteSpace($relative)) {
            $files += $relative.Replace([char]92, '/')
        }
    }
    return @($files | Sort-Object -Unique)
}

function Get-FallbackScan {
    param([string]$Root)

    $items = Get-ChildItem -Path $Root -Recurse -File
    $files = @()
    foreach ($item in $items) {
        $relative = [System.IO.Path]::GetRelativePath($Root, $item.FullName).Replace([char]92, '/')
        if ($relative.StartsWith('.git/')) { continue }
        $files += $relative
    }
    return $files | Sort-Object -Unique
}

$resolvedRoot = (Resolve-Path $RepoRoot).Path
$resolvedState = $StatePath
if (-not [System.IO.Path]::IsPathRooted($resolvedState)) {
    $resolvedState = Join-Path $resolvedRoot $resolvedState
}

$state = Get-SandstrawState -Path $resolvedState
$monitor = if ($state.monitor) { $state.monitor } else { @{} }

if (-not ($monitor.enabled -eq $true)) {
    [pscustomobject]@{
        sandstraw_owned = @();
        unmapped = @();
        ignored = @();
        all_changed = @();
    } | ConvertTo-Json -Depth 10
    exit 0
}

$allChanged = @(Get-GitChangedFiles -Root $resolvedRoot)
if ($allChanged.Count -eq 0) {
    $allChanged = @(Get-FallbackScan -Root $resolvedRoot)
}

$sandstrawOwned = @()
$unmapped = @()
$ignored = @()

foreach ($path in $allChanged) {
    if ([string]::IsNullOrWhiteSpace($path)) { continue }

    $normalized = $path.Replace([char]92, '/')

    if ($normalized.StartsWith('.git/')) {
        $ignored += $normalized
        continue
    }

    if ($normalized.StartsWith('.sandstraw/') -or $normalized -eq '.sandstraw') {
        $sandstrawOwned += $normalized
        continue
    }

    $parts = $normalized.Split('/')
    if ($parts -contains '.git' -or $parts -contains 'node_modules' -or $parts -contains '__pycache__' -or $parts -contains '.venv' -or $parts -contains 'venv') {
        $ignored += $normalized
        continue
    }

    $unmapped += $normalized
}

[pscustomobject]@{
    sandstraw_owned = @($sandstrawOwned | Sort-Object -Unique)
    unmapped = @($unmapped | Sort-Object -Unique)
    ignored = @($ignored | Sort-Object -Unique)
    all_changed = @($allChanged | Sort-Object -Unique)
} | ConvertTo-Json -Depth 10
