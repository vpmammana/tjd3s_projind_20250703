find . -name "frases_*.txt" -exec cat {} \; | awk "NF" | awk 'BEGIN{FS="|"}{print $2; print $5; print $8; print $11; print $14;}'
