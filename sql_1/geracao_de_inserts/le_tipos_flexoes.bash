find . -name "frases_*.txt" -exec cat {} \; | awk "NF" | awk 'BEGIN{FS="|"}{print $3; print $6; print $9; print $12; print $15;}'
