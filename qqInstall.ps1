# 设置 QQ 安装程序的下载链接
$qqInstallerUrl = "https://dldir1.qq.com/qqfile/qq/QQNT/Windows/QQ_9.9.16_241023_x64_01.exe" # 请检查并更新为最新版本的下载链接

# 下载 QQ 安装程序
$installerPath = "$env:TEMP\QQInstaller.exe"
Invoke-WebRequest -Uri $qqInstallerUrl -OutFile $installerPath

# 静默安装 QQ
Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

# 清理安装文件
Remove-Item $installerPath
