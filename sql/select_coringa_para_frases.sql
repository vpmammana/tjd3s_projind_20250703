select group_concat(nome_token order by ordem separator " ") frase from tokens join frases on id_token = id_chave_token join tipos_acoes on id_tipo_acao = id_chave_tipo_acao join tipos_resultados on id_tipo_resultado = id_chave_tipo_resultado  group by id_tipo_acao order by frase;

