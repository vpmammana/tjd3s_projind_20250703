<?php
include 'database.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Consulta de resumo
$sql = "SELECT
            tr.numeracao_tipo_resultado,
            COUNT(DISTINCT ta.id_chave_tipo_acao) AS quantidade_tipos_acoes,
            COUNT(DISTINCT f.id_token) AS total_frases
        FROM tipos_resultados tr
        JOIN tipos_acoes ta ON ta.id_tipo_resultado = tr.id_chave_tipo_resultado
        JOIN frases f ON f.id_tipo_acao = ta.id_chave_tipo_acao
        JOIN tokens t ON t.id_chave_token = f.id_token
        GROUP BY tr.numeracao_tipo_resultado

        UNION ALL

        SELECT
            'TOTAL' AS numeracao_tipo_resultado,
            COUNT(DISTINCT ta.id_chave_tipo_acao),
            COUNT(f.id_token)
        FROM tipos_resultados tr
        JOIN tipos_acoes ta ON ta.id_tipo_resultado = tr.id_chave_tipo_resultado
        JOIN frases f ON f.id_tipo_acao = ta.id_chave_tipo_acao
        JOIN tokens t ON t.id_chave_token = f.id_token";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Resumo de Ações e Frases</title>
    <style>
        body {
            background-color: #1a1a1a;
            color: #f0f0f0;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>

<h2>Resumo de Ações e Frases por Tipo de Resultado</h2>
<table>
    <tr>
        <th>Tipo de Resultado</th>
        <th>Quantidade de Tipos de Ações</th>
        <th>Total de Frases</th>
    </tr>
    <?php while ($row = $result->fetch_assoc()) : ?>
        <tr>
            <td><?= htmlspecialchars($row['numeracao_tipo_resultado']) ?></td>
            <td><?= htmlspecialchars($row['quantidade_tipos_acoes']) ?></td>
            <td><?= htmlspecialchars($row['total_frases']) ?></td>
        </tr>
    <?php endwhile; ?>
</table>

</body>
</html>

<?php $conn->close(); ?>

