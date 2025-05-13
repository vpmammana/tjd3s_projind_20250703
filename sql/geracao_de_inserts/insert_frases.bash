find . -name "frases_temp_*.csv" -exec cat {} \; | tr -d '\r\000-\010\013\014\016-\037'  | awk "NF" | awk '

BEGIN { FS = "|" }

{
    # Gera o timestamp como semente
    "date +%s%N" | getline data_hora
    close("date +%s%N")

    # Cria um hash SHA-256 a partir do timestamp e armazena apenas o valor do hash
    cmd = "echo -n " data_hora " | sha256sum | awk \047{ print $1 }\047"
    cmd | getline hash_unico_sem_caracteres_especiais
    close(cmd)

    print "INSERT INTO tipos_acoes (nome_tipo_acao, id_tipo_resultado, id_tipo_elemento_sintatico) VALUES (\"" hash_unico_sem_caracteres_especiais "\", (SELECT id_chave_tipo_resultado FROM tipos_resultados WHERE nome_tipo_resultado = \"" $16 "\"), (SELECT id_chave_tipo_elemento_sintatico FROM tipos_elementos_sintaticos WHERE nome_tipo_elemento_sintatico = \"entrega no passado\"));\n" 
    print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_chave_token FROM tokens WHERE nome_token = \"" $1 "\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \"" $2 "\")), (SELECT id_chave_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \"" hash_unico_sem_caracteres_especiais "\"), 1);\n";
    print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_chave_token FROM tokens WHERE nome_token = \"" $4 "\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \"" $5 "\")), (SELECT id_chave_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \"" hash_unico_sem_caracteres_especiais "\"), 2);\n";
    print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_chave_token FROM tokens WHERE nome_token = \"" $7 "\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \"" $8 "\")), (SELECT id_chave_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \"" hash_unico_sem_caracteres_especiais "\"), 3);\n";
    print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_chave_token FROM tokens WHERE nome_token = \"" $10 "\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \"" $11 "\")), (SELECT id_chave_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \"" hash_unico_sem_caracteres_especiais "\"), 4);\n";
    print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_chave_token FROM tokens WHERE nome_token = \"" $13 "\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \"" $14 "\")), (SELECT id_chave_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \"" hash_unico_sem_caracteres_especiais "\"), 5);\n";
}
'


