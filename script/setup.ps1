# 保护红魔馆 - 开发环境安装脚本
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "===================================" -ForegroundColor Cyan
Write-Host " 保护红魔馆 - 开发环境安装脚本" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

# 检查 Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "[错误] 未找到 Python，请先安装 Python 3.8+" -ForegroundColor Red
    Write-Host "下载地址: https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}
Write-Host "[OK] Python 已安装" -ForegroundColor Green

# 安装 gdtoolkit
Write-Host "`n[1/2] 安装 gdtoolkit ..."
pip install "gdtoolkit==4.*" --quiet
if ($LASTEXITCODE -ne 0) {
    Write-Host "[错误] gdtoolkit 安装失败" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] gdtoolkit 安装完成" -ForegroundColor Green

# 安装 pre-commit
Write-Host "`n[2/2] 安装 pre-commit ..."
pip install pre-commit --quiet
if ($LASTEXITCODE -ne 0) {
    Write-Host "[错误] pre-commit 安装失败" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] pre-commit 安装完成" -ForegroundColor Green

# 注册 git hook
Write-Host "`n注册 git hook ..."
Set-Location "$PSScriptRoot\.."
python -m pre_commit install
if ($LASTEXITCODE -ne 0) {
    Write-Host "[错误] git hook 注册失败，请确认当前目录是 git 仓库" -ForegroundColor Red
    exit 1
}

Write-Host "`n===================================" -ForegroundColor Cyan
Write-Host " 安装完成！之后每次 commit 会自动" -ForegroundColor Cyan
Write-Host " 进行代码风格检查。" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
