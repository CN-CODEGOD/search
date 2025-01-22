$response=Invoke-WebRequest "https://www.jiligamefun.com/category/photo"
$links=(($response.Links|Where-Object {$_ -notlike "*author*" -and $_ -notlike "*category*" -and $_ -notlike "*311285*"})[6..45]|%{($_.href)}) |Select-Object -Unique


$TITLEs=$response.images.alt|Where-Object {$_ -notlike "AL6"}
$combined = @()
for ($i = 0; $i -lt $titles.Length; $i++) {
    $combined += [PSCustomObject]@{
        Title = $titles[$i]
        Link  = $links[$i]
    }
}

$combined