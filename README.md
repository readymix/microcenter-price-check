# microcenter-price-check
A small script to check Microcenter pricing and alert when the price is in range.

I've included some simple call-outs to Blink(1) control in the alerting, but you could use email, Slack, etc... to alert yourself to the price changes.  You might not have the "greenalert" pattern on your Blink1Control2 settings.  If that's the case, you'll need to either create it, or you can just use a pattern that you like.  Or light it green steady.  Whatever works for you.

You will need to set the path to the CSV file before you start using the script.  The items in the CSV file are just there as examples from when I was putting this script together.

The CSV file is formatted as follows:
item = Item number from the Microcenter site.  Usually after /product/ in the URL.
goprice = This is your "Go Price" threshold that you set.  I usually set this to whatever Microcenter has it set to currently, as the script will alert you if the price goes lower than that.
url = This is the URL for the item page on Microcenter's site.  
