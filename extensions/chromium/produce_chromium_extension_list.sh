#!/bin/bash

# Produce a list of chromium extension ids that have been flagged as malicious 

echo "extensionID,reference" > suspicious_chromium_extensions.csv

cat "./sources.txt" | while read link
do
    echo "Parsing $link"
    escaped_link=$(printf '%s\n' "$link" | sed -e 's/[]\/$*.^[]/\\&/g');
    curl -s $link | egrep -o "[a-z]{32}" | sort | uniq | sed "s/$/,\"${escaped_link}\"/g" >> suspicious_chromium_extensions.csv
done
