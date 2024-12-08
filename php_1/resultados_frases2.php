<?php
include 'database.php'; // Inclui as credenciais de conexão

// Configuração da conexão com o banco de dados
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Consulta principal
$sql = "
SELECT * FROM (
    SELECT 
        CONCAT('(', GROUP_CONCAT(DISTINCT tr1.numeracao_tipo_resultado ORDER BY 
            CAST(SUBSTRING_INDEX(tr1.numeracao_tipo_resultado, '.', 1) AS UNSIGNED),
            CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(tr1.numeracao_tipo_resultado, '.', 2), '.', -1) AS UNSIGNED),
            CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(tr1.numeracao_tipo_resultado, '.', 3), '.', -1) AS UNSIGNED)
        ), ') ', tr1.nome_tipo_resultado) AS tipo_resultado_principal,
        
        GROUP_CONCAT(DISTINCT CONCAT(tr2.numeracao_tipo_resultado, ' ', tr2.nome_tipo_resultado) 
            ORDER BY 
            CAST(SUBSTRING_INDEX(tr2.numeracao_tipo_resultado, '.', 1) AS UNSIGNED),
            CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(tr2.numeracao_tipo_resultado, '.', 2), '.', -1) AS UNSIGNED),
            CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(tr2.numeracao_tipo_resultado, '.', 3), '.', -1) AS UNSIGNED)
            SEPARATOR '\n'
        ) AS tipos_resultado_inferior,
        
        COUNT(DISTINCT ta.id_chave_tipo_acao) AS total_tipos_acoes,
        tr1.numeracao_tipo_resultado,
        tr1.nome_tipo_resultado
    FROM 
        tipos_resultados tr1
    LEFT JOIN 
        tipos_resultados tr2 ON tr2.id_tipo_resultado_pai = tr1.id_chave_tipo_resultado
    LEFT JOIN 
        tipos_acoes ta ON ta.id_tipo_resultado = tr2.id_chave_tipo_resultado
    WHERE 
        tr1.id_tipo_resultado_pai IS NULL
    GROUP BY 
        tr1.nome_tipo_resultado, tr1.numeracao_tipo_resultado
) AS subquery
ORDER BY 
    CAST(SUBSTRING_INDEX(numeracao_tipo_resultado, '.', 1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(numeracao_tipo_resultado, '.', 2), '.', -1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(numeracao_tipo_resultado, '.', 3), '.', -1) AS UNSIGNED);

";

$result = $conn->query($sql);

// Gera a página HTML
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Consulta de Tipos de Resultados</title>
    <style>
        body {
            background-color: #1a1a1a;
            color: #f0f0f0;
            font-family: Arial, sans-serif;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #333;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #333;
        }
        .indent-text {
            padding-left: 3em; /* Define uma margem para o texto, alinhando-o */
            text-indent: -3em; /* Move a primeira linha para a esquerda */
        }
        .numeracao {
            font-weight: bold;
            white-space: nowrap;
        }
        a {
            color: #00bcd4;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Consulta de Tipos de Resultados</h2>
<table>
    <tr>
        <th>Tipo Resultado (Nível Mais Alto)</th>
        <th>Tipos de Resultado Inferiores</th>
        <th>Total de Tipos de Ações</th>
    </tr>
    <?php while ($row = $result->fetch_assoc()) : ?>
        <tr>
            <td><?= htmlspecialchars($row['tipo_resultado_principal']) ?></td>
            <td>
                <?php
                // Exibe os tipos de resultado inferior com numeracao e texto indentado
                $tipos_resultado_inferior = explode("\n", $row['tipos_resultado_inferior']);
                foreach ($tipos_resultado_inferior as $tipo_resultado) {
                    list($numeracao, $nome) = explode(" ", $tipo_resultado, 2);
                    echo '<div><span class="numeracao"><a href="detalhes.php?numeracao_tipo_resultado=' . urlencode($numeracao) . '" target="_blank">' . htmlspecialchars($numeracao) . '</a></span> <span class="indent-text">' . htmlspecialchars($nome) . '</span></div>';
                }
                ?>
            </td>
            <td><?= htmlspecialchars($row['total_tipos_acoes']) ?></td>
        </tr>
    <?php endwhile; ?>
</table>

<p><a href="resumo.php" target="_blank">Ver resumo de ações e frases por tipo de resultado</a></p>

</body>
</html>

<?php $conn->close(); ?>

