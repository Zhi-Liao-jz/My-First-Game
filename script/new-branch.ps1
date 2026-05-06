# 快速创建分支脚本
# 创建格式为 {用户名缩写}{日期缩写}-{分支内容} 的分支，如 ylh43-dev

param(
    [string]$BranchSuffix = "dev",
    [switch]$Local,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Join-Path $scriptDir "..\" | Resolve-Path
$configFile = Join-Path $projectRoot ".branch-user"
$hasChanges = $false

function Show-Help {
    Write-Host "快速创建分支脚本"
    Write-Host ""
    Write-Host "用法:"
    Write-Host "  .\new-branch.ps1 [选项] [分支后缀]"
    Write-Host ""
    Write-Host "选项:"
    Write-Host "  -Local            在当前分支上创建新分支（不切换到 master、不检查工作区状态）"
    Write-Host "  -Help             显示此帮助信息"
    Write-Host ""
    Write-Host "参数:"
    Write-Host "  分支后缀          分支名称的后缀部分（默认: dev）"
    Write-Host ""
    Write-Host "示例:"
    Write-Host "  .\new-branch.ps1              # 创建 ylh43-dev 格式的分支"
    Write-Host "  .\new-branch.ps1 feature      # 创建 ylh43-feature 格式的分支"
    Write-Host "  .\new-branch.ps1 fix-bug      # 创建 ylh43-fix-bug 格式的分支"
    Write-Host ""
    Write-Host "说明:"
    Write-Host "  - 首次运行会提示输入姓名拼音首字母缩写（如 ylh），保存在 .branch-user 文件中"
    Write-Host "  - 缩写为 2~4 位纯小写字母"
    Write-Host "  - 自动切换到 master 分支并拉取最新代码"
    Write-Host "  - 分支名已存在时自动添加数字后缀（如 ylh43-dev2）"
    Write-Host "  - 未提交的更改会自动暂存并在新分支创建后恢复"
    Write-Host ""
    exit 0
}

if ($Help) { Show-Help }

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================"
Write-Host "  快速创建分支"
Write-Host "========================================"
Write-Host ""

# 1. 获取用户名缩写
Write-Host "[1/5] 获取用户名缩写..."

if (Test-Path $configFile) {
    $username = (Get-Content $configFile -Raw).Trim()
    Write-Host "[INFO] 用户名缩写: $username"
} else {
    Write-Host "[INFO] 首次使用，请输入你的姓名拼音首字母缩写（2~4 位纯小写字母，如 ylh）:"
    $username = (Read-Host).ToLower().Trim()

    if ($username -notmatch '^[a-z]{2,4}$') {
        Write-Host "[ERROR] 缩写必须是 2~4 位纯小写字母，请重新运行脚本" -ForegroundColor Red
        exit 1
    }

    $username | Out-File -FilePath $configFile -Encoding utf8 -NoNewline
    Write-Host "[SUCCESS] 用户名已保存到 .branch-user" -ForegroundColor Green
}

# 2. 切换到 master 分支（可选）
Set-Location $projectRoot

if ($Local) {
    Write-Host "[2/5] 本地模式: 在当前分支上创建新分支"
} else {
    Write-Host "[2/5] 切换到 master 分支..."

    git diff --quiet 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        $hasChanges = $true
        Write-Host "[INFO] 检测到未提交的更改，暂存中..."
        git stash push -m "new-branch-script-auto-stash"
    }

    $currentBranch = git branch --show-current

    if ($currentBranch -ne "master") {
        Write-Host "[INFO] 从 $currentBranch 切换到 master..."
        git checkout master
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[ERROR] 无法切换到 master 分支" -ForegroundColor Red
            if ($hasChanges) { git stash pop }
            exit 1
        }
    }

    Write-Host "[INFO] 拉取最新代码..."
    git pull
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] 拉取 master 分支失败" -ForegroundColor Red
        if ($hasChanges) { git stash pop }
        exit 1
    }

    git fetch origin --prune
    Write-Host "[SUCCESS] 已切换到 master 分支并拉取最新代码" -ForegroundColor Green
}

# 3. 获取日期缩写
Write-Host "[3/5] 获取日期缩写..."

$now = Get-Date
$year = $now.Year % 10
$month = $now.Month
$day = $now.Day

$monthChar = if ($month -le 9) { $month.ToString() }
             elseif ($month -eq 10) { "a" }
             elseif ($month -eq 11) { "b" }
             else { "c" }

$dayChar = if ($day -le 9) { $day.ToString() }
           else { [char](97 + $day - 10) }

$dateShort = "$year$monthChar$dayChar"
Write-Host "[INFO] 日期缩写: $dateShort"

# 4. 生成分支名（已存在则加数字后缀）
Write-Host "[4/5] 生成分支名..."

$baseBranchName = "$username$dateShort-$BranchSuffix"
$branchName = $baseBranchName
$counter = 2

while ($true) {
    $localExists  = git branch -a | Select-String -Pattern "^\s+$branchName$"  -Quiet
    $remoteExists = git branch -a | Select-String -Pattern "^\s+remotes/origin/$branchName$" -Quiet

    if (-not $localExists -and -not $remoteExists) { break }

    $branchName = "$baseBranchName$counter"
    $counter++
}

Write-Host "[INFO] 分支名: $branchName"

# 5. 创建分支
Write-Host "[5/5] 创建分支..."

git checkout -b $branchName
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] 创建分支失败" -ForegroundColor Red
    if ($hasChanges) { git stash pop }
    exit 1
}

Write-Host "[SUCCESS] 分支创建成功: $branchName" -ForegroundColor Green

if ($hasChanges) {
    Write-Host "[INFO] 正在恢复暂存的更改..."
    git stash pop
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[WARN] 恢复暂存的更改时出现冲突，请手动解决" -ForegroundColor Yellow
    } else {
        Write-Host "[SUCCESS] 已恢复之前的未提交更改" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "========================================"
Write-Host "[SUCCESS] 完成" -ForegroundColor Green
Write-Host "========================================"
Write-Host ""
Write-Host "当前分支: $branchName"
Write-Host ""
