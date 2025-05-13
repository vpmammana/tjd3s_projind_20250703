SELECT
    t.ta AS id_tipo_acao_a_apagar,
    t.nt AS frase,
    t.tr AS resultado
FROM (
    SELECT
        GROUP_CONCAT(id_token ORDER BY ordem) AS seq,
        GROUP_CONCAT(nome_token ORDER BY ordem SEPARATOR ' ') AS nt,
        id_tipo_acao AS ta,
        nome_tipo_resultado AS tr
    FROM frases
    JOIN tokens ON id_token = id_chave_token
    JOIN tipos_acoes ON id_tipo_acao = id_chave_tipo_acao
    JOIN tipos_resultados ON id_tipo_resultado = id_chave_tipo_resultado
    GROUP BY id_tipo_acao
) AS t
JOIN (
    SELECT
        seq,
        MIN(ta) AS ta_a_manter
    FROM (
        SELECT
            GROUP_CONCAT(id_token ORDER BY ordem) AS seq,
            id_tipo_acao AS ta
        FROM frases
        GROUP BY id_tipo_acao
    ) sub
    GROUP BY seq
    HAVING COUNT(*) > 1
) AS duplicados ON t.seq = duplicados.seq
WHERE t.ta != duplicados.ta_a_manter;

