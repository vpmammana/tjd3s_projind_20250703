-- 1. Criar tabela temporária com os tipos_a_acao duplicados a serem removidos
CREATE TEMPORARY TABLE tipos_para_apagar AS
SELECT ta FROM (
    SELECT t.ta
    FROM (
        SELECT
            GROUP_CONCAT(id_token ORDER BY ordem) AS seq,
            id_tipo_acao AS ta
        FROM frases
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
    WHERE t.ta != duplicados.ta_a_manter
) AS resultado;

-- 2. Apagar frases associadas aos tipos duplicados
DELETE FROM frases
WHERE id_tipo_acao IN (
    SELECT ta FROM tipos_para_apagar
);

-- 3. Apagar os próprios tipos duplicados
DELETE FROM tipos_acoes
WHERE id_chave_tipo_acao IN (
    SELECT ta FROM tipos_para_apagar
);


#-- Apagar frases associadas a tipos_acoes duplicadas
#DELETE FROM frases
#WHERE id_tipo_acao IN (
#  SELECT ta FROM (
#    SELECT t.ta
#    FROM (
#      SELECT
#          GROUP_CONCAT(id_token ORDER BY ordem) AS seq,
#          id_tipo_acao AS ta
#      FROM frases
#      GROUP BY id_tipo_acao
#    ) AS t
#    JOIN (
#      SELECT
#          seq,
#          MIN(ta) AS ta_a_manter
#      FROM (
#          SELECT
#              GROUP_CONCAT(id_token ORDER BY ordem) AS seq,
#              id_tipo_acao AS ta
#          FROM frases
#          GROUP BY id_tipo_acao
#      ) sub
#      GROUP BY seq
#      HAVING COUNT(*) > 1
#    ) AS duplicados ON t.seq = duplicados.seq
#    WHERE t.ta != duplicados.ta_a_manter
#  ) AS tipos_para_apagar
#);
#
#-- Agora apagar os tipos_acoes não mais referenciados
#DELETE FROM tipos_acoes
#WHERE id_chave_tipo_acao IN (
#  SELECT ta FROM (
#    SELECT t.ta
#    FROM (
#      SELECT
#          GROUP_CONCAT(id_token ORDER BY ordem) AS seq,
#          id_tipo_acao AS ta
#      FROM frases
#      GROUP BY id_tipo_acao
#    ) AS t
#    JOIN (
#      SELECT
#          seq,
#          MIN(ta) AS ta_a_manter
#      FROM (
#          SELECT
#              GROUP_CONCAT(id_token ORDER BY ordem) AS seq,
#              id_tipo_acao AS ta
#          FROM frases
#          GROUP BY id_tipo_acao
#      ) sub
#      GROUP BY seq
#      HAVING COUNT(*) > 1
#    ) AS duplicados ON t.seq = duplicados.seq
#    WHERE t.ta != duplicados.ta_a_manter
#  ) AS tipos_para_apagar
#);
#
