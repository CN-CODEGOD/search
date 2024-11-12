function search-for {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet("草榴社区","setu","36dm","pornhub")]
        [string]$search

        )
#草榴社区
function 草榴社区 {
    $caoliushequ=Invoke-WebRequest "https://t66y.com/thread0806.php?fid=7&search=&page=1"
    ($caoliushequ.links|Where-Object  {$_.href -like "htm_data*"})|%{
        $href="https://t66y.com"+$_.href 
        -join $_.outerHTML,$href}
  

    function nextpage {
        [CmdletBinding()]
        param (
            [Parameter(Mandatory)]
            [int]
            $Page

        )
        if ($page -lt 1) {
            throw "页数不能小于1"

        }
        
        $caoliushequ=Invoke-WebRequest "https://t66y.com/thread0806.php?fid=7&search=&page=$page"
        ($caoliushequ.links|Where-Object  {$_.href -like "htm_data*"})|%{
            $href="https://t66y.com"+$_.href 
            -join $_.outerHTML,$href}
        nextpage
    }
    nextpage  
}
#36dm"https://www.36dm.org/"

function 36dm {
   
    $36dm = invoke-webrequest "https://www.36dm.org/"
    $36DM=$36dm.links|Where-Object{$_.outerhtml -like  "*thread*"}
    $36dm=$36dm[3..21]
    $href =$36dm.href|%{ "https://www.36dm.org/"+$_}
    $pages= ($href|%{Invoke-WebRequest $_ })|Where-Object{$_.href -like "magnet:*"}
    $PAGES.LINKS.HREF|Where-Object {$_ -like "magnet:*"}
  
  function nextpage {
[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [int]
    $page
)
if ($page -lt 2) {
    throw '页数不能小于2'
}
$36dm = invoke-webrequest "https://www.36dm.org/index-$page.htm"
$36DM=$36dm.links|Where-Object{$_.outerhtml -like  "*thread*"}
$36dm=$36dm[3..21]
$href =$36dm.href|%{ "https://www.36dm.org/"+$_}
$pages= ($href|%{Invoke-WebRequest $_ })|Where-Object{$_.href -like "magnet:*"}
$PAGES.LINKS.HREF|Where-Object {$_ -like "magnet:*"}
nextpage
}
nextpage
}

#setu https://www.jiligamefun.com
function setu {
  
    $setu=Invoke-WebRequest "https://www.jiligamefun.com/category/photo"
    $links = $SETU.links|Where-Object {$_.outerHTML -like "*p站*"}
    $titles =$SETU.images.alt |Where-Object {$_ -notlike "AL6"}

  foreach ($title in $titles) {
    <# $links is he culinks #>
    
-join $title,(($links|where-object {$_.outerHTML -like "*$title*"}).href)[0]


  }
  function nextpage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]
        $Page
    )
    
    if ($page -lt 2) {
        throw '页数不能小于2'
    }    
    
    $setu=Invoke-WebRequest "https://www.jiligamefun.com/category/photo/page/$page"
    $links = $SETU.links|Where-Object {$_.outerHTML -like "*p站*"}
    $titles =$SETU.images.alt |Where-Object {$_ -notlike "AL6"}
    
    foreach ($title in $titles) {
    <# $links is he culinks #>
    
    -join $title,(($links|where-object {$_.outerHTML -like "*$title*"}).href)[0]
    
      }
      nextpage
    }
nextpage

}
    function pornhub {
        $pornhub = invoke-webrequest "https://cn.pornhub.com/"
            $pornhub.links|Where-Object {$null -ne $_.title} |%{-join $_.title,"https://cn.pornhub.com/+$($_.href)"}    
   
    function nextpage {
   [CmdletBinding()]
   param (
       [Parameter(Mandatory)]
       [int]
       $page

   )

   if ($page -lt 2) {
    throw"页数不能小于2"
   }
   $pornhub = invoke-webrequest "https://cn.pornhub.com/video?page=$page"
   $pornhub.links|Where-Object {$null -ne $_.title} |%{-join $_.title,"https://cn.pornhub.com/+$($_.href)"}    
        nextpage
    }
    nextpage
        }
  
    Invoke-Expression $search
    
}

