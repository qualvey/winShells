
$proxy="http://127.0.0.1:7773"

$envVars = @{
    "https_proxy" =$proxy; 
    "http_proxy" = $proxy;
}

foreach ($key in $envVars.Keys) {
    $value = $envVars[$key]
    $currentValue = [Environment]::GetEnvironmentVariable($key, [EnvironmentVariableTarget]::User)

    if ($currentValue) {
        # 如果环境变量存在，则设置为空值（删除）
        [Environment]::SetEnvironmentVariable($key, $null, [EnvironmentVariableTarget]::User)
        Set-Item -Path "Env:$key" -Value $null
        Write-Host "已删除环境变量 '$key'（设置为空值）。" -ForegroundColor Yellow
    } else {
        # 如果环境变量不存在，则创建
        [Environment]::SetEnvironmentVariable($key, $value, [EnvironmentVariableTarget]::User)
        Set-Item -Path "Env:$key" -Value $value

        Write-Host "已创建环境变量 '$key'，值为：`$value" -ForegroundColor Green
    }
}

