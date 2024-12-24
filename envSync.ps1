#白名单模式
$target=@("https_proxy","http_proxy","test")

foreach ($item in $target) {
	$value= [System.Environment]::GetEnvironmentVariable($item,"User")
	if ($value -eq $null){
		echo "$item is null .Deleting"
		Set-Item -Path "Env:$item" -Value $null
	}else{
		echo "setting $item to $value"
		Set-Item -Path "Env:$item" -Value $value
	  }
}
# 获取用户环境变量和系统环境变量
#$userEnvVars = [System.Environment]::GetEnvironmentVariables("User")
#$machineEnvVars = [System.Environment]::GetEnvironmentVariables("Machine")
# 创建一个新的哈希表来存储合并结果
#$mergedEnvVars = @{}
# 添加用户环境变量到合并哈希表
#foreach ($key in $userEnvVars.Keys) {
#    $mergedEnvVars[$key] = $userEnvVars[$key]
#}
# 合并系统环境变量
#foreach ($key in $machineEnvVars.Keys) {
#    if ($mergedEnvVars.ContainsKey($key)) {
#        # 如果键已存在，合并值（例如用分号分隔）
#        $mergedEnvVars[$key] += ";$($machineEnvVars[$key])"
#    } else {
#        # 如果键不存在，直接添加
#        $mergedEnvVars[$key] = $machineEnvVars[$key]
#    }
#}
#
## 显示结果
#$mergedEnvVars
## 将系统环境变量同步到当前 PowerShell 会话
#foreach ($key in $mergedEnvVars.Keys) {
#    Set-Item -Path "Env:$key" -Value $mergedEnvVars[$key]
#}
#
## 例如，检查某个环境变量是否已设置
#$env:PATH
