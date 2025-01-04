cat frases_3_05.txt | awk 'BEGIN{FS="[|,]"}{gsub(/"/,"",$1); print $1" "$4" "$7" "$10" "$13" ("$16")";}'
