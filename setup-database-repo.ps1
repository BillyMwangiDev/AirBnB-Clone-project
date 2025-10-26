# PowerShell Script to Set Up alx-airbnb-database Repository
# ============================================================

Write-Host "Setting up alx-airbnb-database repository..." -ForegroundColor Green

# Define paths
$currentDir = Get-Location
$newRepoPath = "C:\Users\USER\Desktop\PROJECTS\alx-airbnb-database"

# Create new repository directory
Write-Host "`nCreating new repository directory..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path $newRepoPath -Force | Out-Null

# Copy database-related files and directories
Write-Host "Copying database files..." -ForegroundColor Yellow

# Copy directories
$directories = @("ERD", "normalization", "database-script-0x01", "database-script-0x02")
foreach ($dir in $directories) {
    if (Test-Path $dir) {
        Write-Host "  - Copying $dir/" -ForegroundColor Cyan
        Copy-Item -Path $dir -Destination $newRepoPath -Recurse -Force
    }
}

# Copy root files
$files = @("README.md", ".gitignore", "normalization.md")
foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "  - Copying $file" -ForegroundColor Cyan
        Copy-Item -Path $file -Destination $newRepoPath -Force
    }
}

Write-Host "`nFiles copied successfully!" -ForegroundColor Green

# Navigate to new repo and initialize git
Write-Host "`nInitializing Git repository..." -ForegroundColor Yellow
Set-Location $newRepoPath

git init
git branch -M main

Write-Host "`nGit repository initialized!" -ForegroundColor Green

# Display next steps
Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "NEXT STEPS:" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "1. Add your files to git:" -ForegroundColor Yellow
Write-Host "   git add ." -ForegroundColor White
Write-Host ""
Write-Host "2. Create initial commit:" -ForegroundColor Yellow
Write-Host "   git commit -m 'Initial commit: AirBnB Clone database design'" -ForegroundColor White
Write-Host ""
Write-Host "3. Add your GitHub remote (replace YOUR_USERNAME):" -ForegroundColor Yellow
Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/alx-airbnb-database.git" -ForegroundColor White
Write-Host ""
Write-Host "4. Push to GitHub:" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "Repository location: $newRepoPath" -ForegroundColor Green
Write-Host ""

