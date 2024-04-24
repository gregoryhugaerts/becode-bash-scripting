#!/bin/bash


file="laptops.html"

# Check if the file exists
if [ ! -f "$file" ]; then
    # Run curl to download the file if it doesn't exist
    curl --silent https://webscraper.io/test-sites/e-commerce/allinone/computers/laptops -o "$file"
fi

mapfile -t names < <(grep 'title"' laptops.html | awk -F '"' '{print $6}')
mapfile -t prices < <(grep 'price' laptops.html | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
mapfile -t descriptions < <(grep 'description card-text' laptops.html | awk -F '>' '{print $2}' | awk -F '<' '{print $1}' | sed -e 's/&lt;/</g' -e 's/&gt;/>/g' -e 's/&amp;/\&/g' -e 's/&quot;/"/g')

# loop over all 3 arrays at once with an index
for ((i=0; i < ${#names[@]}; ++i)); do
    printf "%s | %s | %s\n" "${names[i]}" "${descriptions[i]}" "${prices[i]}" # print out the information
done
