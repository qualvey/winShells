
$proxy="http://127.0.0.1:7773"
# 定义要设置的环境变量和它们的值
$envVars = @{
    "https_proxy" =$proxy; 
    "http_proxy" = $proxy;
}

$existingEnvVars = @{}
foreach ($key in $envVars.Keys) {
    $existingEnvVars[$key] = [Environment]::GetEnvironmentVariable($key, [EnvironmentVariableTarget]::User)
}

# 遍历定义的环境变量
foreach ($key in $envVars.Keys) {
    $value = $envVars[$key]
    $currentValue = $existingEnvVars[$key]

    if ($currentValue) {
        Write-Host "环境变量 '$key' 已存在，当前值为：$currentValue" -ForegroundColor Yellow
        
        # 如果是 PATH，则追加新值
        if ($key -eq "PATH") {
            if ($currentValue -notlike "*$value*") {
                $newValue = "$currentValue;$value"
                [Environment]::SetEnvironmentVariable($key, $newValue, [EnvironmentVariableTarget]::User)
                Write-Host "已向 PATH 添加值：$value" -ForegroundColor Green
            } else {
                Write-Host "$value 已存在于 PATH 中，跳过。" -ForegroundColor Cyan
            }
        } else {
            # 默认覆盖其他变量值
            [Environment]::SetEnvironmentVariable($key, $value, [EnvironmentVariableTarget]::User)
            Write-Host "已更新 '$key' 的值为：$value" -ForegroundColor Green
        }
    } else {
        # 如果变量不存在，则创建
        [Environment]::SetEnvironmentVariable($key, $value, [EnvironmentVariableTarget]::User)
        Write-Host "已创建环境变量 '$key'，值为：$value" -ForegroundColor Green
    }
}

Write-Host "环境变量配置完成！请重启终端以使更改生效。" -ForegroundColor Magenta
