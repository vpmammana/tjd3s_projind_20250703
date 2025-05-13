select 
	count(t.seq) repeticao, 
	group_concat(distinct t.nt) frase, 
	min( t.ta) ta, 
	group_concat(distinct t.tr)  
FROM 
	(
		select 
			group_concat(id_token order by ordem) as seq, 
			group_concat(nome_token order by ordem separator ' ') as nt, 
			group_concat(distinct id_tipo_acao) as ta, 
			group_concat(distinct nome_tipo_resultado) as tr 
		from 
			frases join tokens on id_token = id_chave_token 
		join 
			tipos_acoes on id_tipo_acao = id_chave_tipo_acao 
		join 
			tipos_resultados on id_tipo_resultado = id_chave_tipo_resultado 
		group by id_tipo_acao
	) as t 
group by 
	seq 
having 
	repeticao >1;
