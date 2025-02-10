# Fetch all remote branches
$branches = git branch -r | Where-Object { $_ -notmatch 'HEAD' } | ForEach-Object { $_.Trim() -replace 'origin/', '' }

# Get the name of the current branch (the branch you're currently on)
$currentBranch = git rev-parse --abbrev-ref HEAD

# Loop through each branch and merge dev into it
foreach ($branch in $branches) {
    if ($branch -ne $currentBranch) {
        Write-Host "Switching to branch $branch"
        git checkout $branch
        git merge dev
        git push origin $branch
    }
}

# Switch back to the original branch
git checkout $currentBranch
