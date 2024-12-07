find . -name "frases_temp_*.txt" -exec cat {} \; | awk "NF" | awk '

BEGIN{FS="|"}

{
	print "INSERT INTO tipos_acoes (nome_tipo_acao, id_tipo_resultado, id_tipo_elemento_sintatico) VALUES (\""$1" "$4" "$7" "$10" "$13"\", (SELECT id_chave_tipo_resultado FROM tipos_resultados WHERE numeracao_tipo_resultado = \""$16"\"), (SELECT id_chave_tipo_elemento_sintatico FROM tipos_elementos_sintaticos WHERE nome_tipo_elemento_sintatico = \"entrega no passado\"));\n" 
	print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_token FROM tokens WHERE nome_token = \""$1"\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \""$2"\")), (SELECT id_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \""$1" "$4" "$7" "$10" "$13"\"), 1);\n";
	print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_token FROM tokens WHERE nome_token = \""$4"\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \""$5"\")), (SELECT id_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \""$1" "$4" "$7" "$10" "$13"\"), 2);\n";
	print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_token FROM tokens WHERE nome_token = \""$7"\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \""$8"\")), (SELECT id_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \""$1" "$4" "$7" "$10" "$13"\"), 3);\n";
	print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_token FROM tokens WHERE nome_token = \""$10"\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \""$11"\")), (SELECT id_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \""$1" "$4" "$7" "$10" "$13"\"), 4);\n";
	print "INSERT INTO frases (id_token, id_tipo_acao, ordem) VALUES ((SELECT id_token FROM tokens WHERE nome_token = \""$13"\" AND id_tipo_token = (SELECT id_chave_tipo_token FROM tipos_tokens WHERE nome_tipo_token = \""$14"\")), (SELECT id_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = \""$1" "$4" "$7" "$10" "$13"\"), 5);\n";

}
'

