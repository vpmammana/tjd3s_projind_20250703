./le_tokens_tipos.bash | sort | uniq | awk -F'|' 'seen[$1]++ {print prev[$1]; print} {prev[$1] = $0}'
