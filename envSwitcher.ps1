
$proxy="http://127.0.0.1:7773"

$envvars = @{
    "https_proxy" =$proxy; 
    "http_proxy" = $proxy;
}

foreach ($key in $envvars.keys) {
    $value = $envvars[$key]
    $currentvalue = [environment]::getenvironmentvariable($key, [environmentvariabletarget]::user)

    if ($currentvalue) {
        echo "true"
        echo $key $value
        # 如果环境变量存在，则设置为空值（删除）
        $executiontime = measure-command {
          [system.environment]::setenvironmentvariable($key, $null, "user")
        }
        "execution time: {0} milliseconds" -f $executiontime.totalmilliseconds
        set-item -path "env:$key" -value $null
        write-host "已删除环境变量 '$key'（设置为空值）。" -foregroundcolor yellow
    } else {
        echo "creating......###########"
        echo $key $value
        # 如果环境变量不存在，则创建
        $executiontime = measure-command {
          [system.environment]::setenvironmentvariable($key, $value, "user")
         }
         "execution time: {0} milliseconds" -f $executiontime.totalmilliseconds
        set-item -path "env:$key" -value $value
        write-host "已创建环境变量 '$key'，值为：'$value' -foregroundcolor green"
    }
}

