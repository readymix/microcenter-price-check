## Stop Blink(1) Current State.  This is needed as otherwise the states overlap ##
Invoke-RestMethod -Uri "http://localhost:8934/blink1/off"

## Set the item you want to view ##
$uri = "http://www.microcenter.com/product/483132/ryzen-threadripper-1950x-34-ghz-16-core-tr4-boxed-processor"

## Set Blink(1) REST states ##
$blinkurigood = "http://localhost:8934/blink1/pattern/play?pname=greenalert"
$blinkuribad = "http://localhost:8934/blink1/fadeToRGB?rgb=%23ff0000"

## Get Microcenter Data ##
$data = Invoke-WebRequest -uri $uri 

## Pattern Definitions to parse out the price ##
$pattern = "ProductLink_483132(.*?)</span>"
$priceinfo = [regex]::match($data, $pattern).Groups[1].Value
$infopattern = "data-price=(.*?) data"
$pricevalue = [regex]::match($priceinfo, $infopattern).Groups[1].Value
$price = $pricevalue.Replace("`"","")

## Price Check ##
if($price -lt '649.99')
    {
    Write-Host "Price is $price, is that low enough for you?!"
    Invoke-WebRequest -uri $blinkurigood
    }
if($price -eq '649.99')
    {
    Write-Host "Price is still 649.99, ignore this"
    Invoke-WebRequest -Uri $blinkuribad
    }