param(
  [string]$src,
  [string]$target="main"
)
# 检查源文件是否存在
if (-not (Test-Path $src)) {
    Write-Host "源文件不存在：$src" -ForegroundColor Red
    exit 1
}
# 如果目标文件已经存在，询问是否覆盖
if (Test-Path $target) {
    $overwrite = Read-Host "目标文件 $target 已存在，是否覆盖？(Y/N)"
    if ($overwrite -ne 'Y') {
        Write-Host "操作已取消。" -ForegroundColor Yellow
        exit 0
    }
}
Write-Host "正在编译 $src 到 $target..." -ForegroundColor Green
$gccOutput = gcc $src -o $target $args 2>&1  # 捕获 gcc 的输出和错误


# 检查 gcc 编译是否成功
if ($LASTEXITCODE -ne 0) {
    Write-Host "编译失败：" -ForegroundColor Red
    Write-Host $gccOutput -ForegroundColor Red
    exit 1
} else {
    Write-Host "编译成功，输出文件：$target" -ForegroundColor Green
}

# 提供运行目标程序的选项
$runProgram = Read-Host "是否运行编译后的程序？(Y/N) [默认为 Y]"
if ([string]::IsNullOrEmpty($runProgram) -or $runProgram -eq 'Y') {
    Write-Host "正在运行程序..." -ForegroundColor Green
    & ".\$target"  # 运行目标程序
} else {
    Write-Host "程序未运行。" -ForegroundColor Yellow
}
