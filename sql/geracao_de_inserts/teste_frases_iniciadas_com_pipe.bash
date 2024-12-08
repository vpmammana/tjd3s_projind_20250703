find . -name "frases_temp_*.txt" | while read file; do
    if grep -q '^|' "$file"; then
        echo "Arquivo com linha começando com |: $file"
    fi
done
