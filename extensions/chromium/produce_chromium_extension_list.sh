#!/bin/bash

# Produce a list of chromium extension ids that have been flagged as malicious 

# Declare an array of string with type
# Space seperate list
declare -a StringArray=("https://www.trendmicro.com/vinfo/us/security/news/cybercrime-and-digital-threats/chrome-extensions-malicious-domains-used-to-steal-user-data" "https://www.catonetworks.com/blog/threat-intelligence-feeds-and-endpoint-protection-systems-fail-to-detect-24-malicious-chrome-extensions/" "https://duo.com/labs/research/crxcavator-malvertising-2020" "https://aristanetworks.force.com/AristaCommunity/s/article/Google-Doppelganger-Malicious-Chrome-Extension" "https://github.com/mallorybowes/chrome-mal-ids" "https://github.com/uku/malicious-chrome-extensions" "https://blog.avast.com/greedy-cybercriminals-host-malware-on-github" "https://awakesecurity.com/wp-content/uploads/2020/06/GalComm-Malicious-Chrome-Extensions-Appendix-B.txt" "https://duo.com/decipher/malicious-chrome-extension-backdoor-uncovered-in-malware-campaign" "https://heimdalsecurity.com/blog/malicious-chrome-extension/" "https://www.gosecure.net/blog/2022/02/10/malicious-chrome-browser-extension-exposed-chromeback-leverages-silent-extension-loading/" "https://aristanetworks.force.com/AristaCommunity/s/article/Google-Doppelganger-Malicious-Chrome-Extension" "https://www.tomsguide.com/news/these-malicious-chrome-extensions-have-more-than-14-million-users-delete-them-now" "https://www.mcafee.com/blogs/other-blogs/mcafee-labs/malicious-cookie-stuffing-chrome-extensions-with-1-4-million-users")

# Iterate the string array using for loop

echo "extensionID,reference" > suspicious_chromium_extensions.csv

for link in ${StringArray[@]}; do
    echo "Parsing $link"
    escaped_link=$(printf '%s\n' "$link" | sed -e 's/[]\/$*.^[]/\\&/g');
    curl -s $link | egrep -o "[a-z]{32}" | sort | uniq | sed "s/$/,\"${escaped_link}\"/g" >> suspicious_chromium_extensions.csv
done
