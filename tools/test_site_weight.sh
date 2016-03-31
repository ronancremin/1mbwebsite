#!/bin/sh
echo "Payload\tHeaders\tTotal\tCode\tFinal URL"

cat site_manifest_live.txt \
| xargs --max-args=1 -I {} \
  curl  --header "Accept-Encoding: gzip,deflate" \
        --write-out "%{size_download} %{size_header} %{http_code} %{url_effective}\n"  \
        --output /dev/null \
        --silent {} \
| awk '
    {
        sum = sum + $1 + $2 
        print $1 "\t" $2 "\t" $1+$2 "\t" $3 "\t" $4
    } 
    END {
        print "\nTotal page transfer weight including headers: " sum" bytes, " sum/1048576 " MB"
        print "Desired size is: " 1024 * 1024 " bytes"
        print "Shortfall is: " 1024 * 1024 - sum " bytes"
    }
'
