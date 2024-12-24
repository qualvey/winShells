param(
  $newpath
)

$PATH=[System.Environment]::GetEnvironmentVariable("PATH","USER")

if($newpath[-1] -eq ";"){
  $PATH=$newpath+$PATH
}
else{
  $PATH=$newpath+";"+$PATH
}

[System.Environment]::SetEnvironmentVariable("PATH",$PATH,"USER")
$Env:path=$PATH

