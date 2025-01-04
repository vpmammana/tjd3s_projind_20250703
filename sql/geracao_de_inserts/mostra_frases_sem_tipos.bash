cat frases_temp_1_10.txt | awk 'BEGIN{FS="[|,]"}{gsub(/"/,"",$1); print $1" "$4" "$7" "$10" "$13" ("$16")";}'
