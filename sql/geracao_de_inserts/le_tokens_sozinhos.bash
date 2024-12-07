find . -name "frases_*.txt" -exec cat {} \; | awk "NF" | awk 'BEGIN{FS="|"}{print $1; print $4; print $7; print $10; print $13;}'
