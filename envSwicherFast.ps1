
$proxy = "http://127.0.0.1:7773"

$envvars = @{
    "https_proxy" = $proxy; 
    "http_proxy"  = $proxy;
}

# 获取用户环境变量注册表路径
$envRegPath = "HKCU:\Environment"

foreach ($key in $envvars.Keys) {
    $value = $envvars[$key]
    
    # 获取当前注册表中的环境变量值
    $currentValue = Get-ItemProperty -Path $envRegPath -Name $key -ErrorAction SilentlyContinue

    if ($currentValue) {
        Write-Host "Found existing environment variable: $key"
        Write-Host "$key = $value"

        # 如果环境变量存在，则删除
        $executionTime = Measure-Command {
            Remove-ItemProperty -Path $envRegPath -Name $key
        }
        Write-Host "Execution time for deleting: {0} milliseconds" -f $executionTime.TotalMilliseconds

        Write-Host "Deleted environment variable '$key'." -ForegroundColor Yellow
    } else {
        Write-Host "Creating environment variable: $key"
        Write-Host "$key = $value"

        # 如果环境变量不存在，则创建
        $executionTime = Measure-Command {
            Set-ItemProperty -Path $envRegPath -Name $key -Value $value
        }
        Write-Host "Execution time for creating: {0} milliseconds" -f $executionTime.TotalMilliseconds

        Write-Host "Created environment variable '$key' with value: '$value'" -ForegroundColor Green
    }

    # 更新 PowerShell 会话中的环境变量
    Set-Item -Path "env:$key" -Value $value
}
