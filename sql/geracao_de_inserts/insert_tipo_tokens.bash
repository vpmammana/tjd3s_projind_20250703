./le_tipos_tokens.bash | awk 'NF' | sort | uniq | awk '{print "INSERT INTO tipo_tokens (nome_tipo_token) VALUES (\x27"$1"\x27);"}' > insert_tipo_tokens.sql
