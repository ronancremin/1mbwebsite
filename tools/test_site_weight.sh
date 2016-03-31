#!/bin/sh
echo "Payload Headers"
cat site_manifest_live.txt | xargs -n 1 -I {} curl --header "Accept-Encoding: gzip,deflate" --write-out "%{size_download} %{size_header} \n" --output /dev/null -silent {} | awk '{sum = sum + $1 + $2} {print $1, $2} END {print "Total page size: " sum" bytes, " sum/1048576 "MB"}'
