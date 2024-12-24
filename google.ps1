param(
  [Parameter(Mandatory = $true)]
  [string]$keyWord,

  [string]$title,
  [string]$filetype
)
$filetype="pdf"
# 定义搜索关键词和排除的网站
$excludedSites = @("zhihu.com", "csdn")
#排除包含以下关键词的结果
$noContain=@()
$InTitle  = " intile:$title"
$fileType = " filetype:$filetype"

# 构建排除网站的参数
$excludeParams = ""
foreach ($site in $excludedSites) {
    $excludeParams += " -site:$site"
}

$no=""
foreach ($key in $noContain){
  $no+= " -$key"
  }

$FinalParam=$keyWord+$excludeParams+$no+$fileType
# 构建最终的搜索 URL
$searchURL = "https://www.google.com/search?q=" + [System.Web.HttpUtility]::UrlEncode($FinalParam)

# 启动 Chrome 浏览器并执行搜索
Start-Process "chrome.exe" $searchURL
