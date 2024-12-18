<?php
include 'database.php';

$numeracao_tipo_resultado = $_GET['numeracao_tipo_resultado'] ?? '';
$nome = $_GET['nome_tipo_resultado'] ?? '';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Consulta para mostrar os tipos de ações para o numeracao_tipo_resultado especificado
$sql = "SELECT GROUP_CONCAT(nome_token SEPARATOR ', ') AS tokens
        FROM tokens
        JOIN frases ON id_token = id_chave_token
        JOIN tipos_acoes ON id_tipo_acao = id_chave_tipo_acao
        WHERE id_chave_tipo_acao IN (
            SELECT id_chave_tipo_acao 
            FROM tipos_acoes 
            WHERE id_tipo_resultado = (
                SELECT id_chave_tipo_resultado 
                FROM tipos_resultados 
                WHERE numeracao_tipo_resultado = '$numeracao_tipo_resultado'
            )
        )
        GROUP BY id_chave_tipo_acao";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Detalhes para <?= htmlspecialchars($numeracao_tipo_resultado) ?> - <?=htmlspecialchars($nome) ?> </title>
    <style>
        body {
            background-color: #1a1a1a;
            color: #f0f0f0;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>

<h2>Tipos de Ações para <?= htmlspecialchars($numeracao_tipo_resultado) ?> - <?=htmlspecialchars($nome) ?>  </h2>
<ul>
    <?php while ($row = $result->fetch_assoc()) : ?>
        <li><?= htmlspecialchars($row['tokens']) ?></li>
    <?php endwhile; ?>
</ul>

</body>
</html>

<?php $conn->close(); ?>

