# Fetch all remote branches
$branches = git branch -r | Where-Object { $_ -notmatch 'HEAD' } | ForEach-Object { $_.Trim() -replace 'origin/', '' }

# Loop through each branch and merge dev into it
foreach ($branch in $branches) {
    if ($branch -ne "dev") {
        Write-Host "Switching to branch $branch"
        git checkout $branch
        git merge dev
        git push origin $branch
    }
}

# Switch back to the dev branch at the end
git checkout dev
