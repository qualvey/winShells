param(
  [string]$type="global",
  [string]$status
)

$proxy="http://127.0.0.1:7773"
$envvars = @{
    "https_proxy" =$proxy; 
    "http_proxy" = $proxy;
}

function proxySwitch {
  param (
    $flag=""
  )

foreach ($key in $envvars.keys) {
    $value = $envvars[$key]
    $currentvalue = [environment]::getenvironmentvariable($key, [environmentvariabletarget]::user)

    if ($currentvalue -and $flag -ne "on") {
        echo "true"
        echo $key $value
        # 如果环境变量存在，则设置为空值（删除）
        $executiontime = measure-command {
          [system.environment]::setenvironmentvariable($key, $null, "user")
        }
        "execution time: {0} milliseconds" -f $executiontime.totalmilliseconds
        set-item -path "env:$key" -value $null
        write-host "已删除全局环境变量 '$key'（设置为空值）。" -foregroundcolor yellow
    } elseif ($flag -eq "on") {
        echo "creating......###########"
        echo $key $value
        # 如果环境变量不存在，则创建
        $executiontime = measure-command {
          [system.environment]::setenvironmentvariable($key, $value, "user")
         }
         "execution time: {0} milliseconds" -f $executiontime.totalmilliseconds
        set-item -path "env:$key" -value $value
        write-host "已创建全局环境变量 '$key'，值为：'$value' -foregroundcolor green"
    }
   //final 
    {
        echo "creating......###########"
        echo $key $value
        # 如果环境变量不存在，则创建
        $executiontime = measure-command {
          [system.environment]::setenvironmentvariable($key, $value, "user")
         }
         "execution time: {0} milliseconds" -f $executiontime.totalmilliseconds
        set-item -path "env:$key" -value $value
        write-host "已创建全局环境变量 '$key'，值为：'$value' -foregroundcolor green"
      }
    
  }
}

function justNow ($status) {
  switch ($status) {
    "on"{ 
        $env:https_proxy=$proxy
        $env:http_proxy =$proxy
        echo "proxy added in this session."
      }
    "off"{

        $env:https_proxy=$null
        $env:http_proxy=$null
        echo "proxy removed in this session."
      }
    Default {}
  }
}

switch ($Type) {
  "global" {  
          proxySwitch($status)
        }

  "current"{
    if($status){
      justNow($status)
    } else{
      echo 'proxy status is requered,"on" or "off"'
    }
    }
      Default {
        proxySwitch("")
        }
  }

