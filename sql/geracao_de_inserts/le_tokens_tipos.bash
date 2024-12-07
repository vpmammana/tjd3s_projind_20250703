find . -name "frases_*.txt" -exec cat {} \; | awk "NF" | awk 'BEGIN{FS="|"}{print $1"|"$2"|"$3; print $4"|"$5"|"$6; print $7"|"$8"|"$9; print $10"|"$11"|"$12; print $13"|"$14"|"$15;}'
