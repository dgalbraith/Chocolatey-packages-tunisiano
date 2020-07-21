import-module au

$releases = 'https://github.com/electron/electron/releases/latest/'

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$url32 = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'BraveBrowserNightlySetup32.exe'}).href
	$url64 = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'BraveBrowserNightlySetup.exe'}).href
	Write-Output 'Checking version'
	$version = $url64 = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'Brave-v'}).split('v')[1].split('-')[0]
	Write-Output "Version : $version"
	$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

	$url32 = "https://github.com$($url32)";
	Invoke-WebRequest -Uri $url32 -OutFile $(Join-Path $toolsPath "BraveBrowserSilentSetup32.exe")
	$url64 = "https://github.com$($url64)";
	Invoke-WebRequest -Uri $url64 -OutFile $(Join-Path $toolsPath "BraveBrowserSilentSetup.exe")

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none