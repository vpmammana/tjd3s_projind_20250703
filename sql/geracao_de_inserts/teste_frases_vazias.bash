find . -name "frases_temp_*.txt" | while read file; do
    awk '
    BEGIN { FS = "|" }
    {
        if ($1 == "") {
            print "Frase vazia"
            print $0" - " FILENAME
            print "----------------"
        }
    }' "$file"
done

