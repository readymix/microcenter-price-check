## Stop Blink(1) Current State.  This is needed as otherwise the states overlap ##
Invoke-RestMethod -Uri "http://localhost:8934/blink1/off"

## Import CSV Formatted List of Products to Check ##
$list = Import-Csv -Path C:\scripts\data\microcenter.csv

## Set Blink(1) REST states ##
$blinkurigood = "http://localhost:8934/blink1/pattern/play?pname=greenalert"
$blinkuribad = "http://localhost:8934/blink1/fadeToRGB?rgb=%23ff0000"

$list |% {
    
    ## Set loop variables ##
    $uri = $null
    $uri = $_.url
    $item = $null
    $item = $_.item
    $goprice = $null
    $goprice = $_.goprice

    ## Get Microcenter Data ##
    $data = Invoke-WebRequest -uri $uri 
    
    ## Pattern Definitions to parse out the price ##
    $pattern = "ProductLink_$item(.*?)</span>"
    $priceinfo = [regex]::match($data, $pattern).Groups[1].Value
    $infopattern = "data-price=(.*?) data"
    $pricevalue = [regex]::match($priceinfo, $infopattern).Groups[1].Value
    $price = $pricevalue.Replace("`"","")
    
    ## Price Check ##
    if($price -lt $goprice)
        {
        Write-Host "Price is $price, is that low enough for you?!"
        Invoke-WebRequest -uri $blinkurigood
        }
    if($price -eq $goprice)
        {
        Write-Host "Price is still $goprice, ignore this"
        Invoke-WebRequest -Uri $blinkuribad
        }
}