<?php
// Inclui o arquivo de conexão ao banco de dados
include 'database_conecta.php';

// Defina o cabeçalho de conteúdo para evitar quirks mode
header('Content-Type: text/html; charset=utf-8');

// Realiza a consulta ao banco de dados
try {
    $query = "SELECT 
                GROUP_CONCAT(DISTINCT tr1.numeracao_tipo_resultado) AS numeracao1, 
                GROUP_CONCAT(DISTINCT tr2.numeracao_tipo_resultado) AS numeracao2, 
                GROUP_CONCAT(DISTINCT tr2.nome_tipo_resultado) AS nome_tipo_resultado1, 
                GROUP_CONCAT(DISTINCT tr1.nome_tipo_resultado) AS nome_tipo_resultado2, 
                GROUP_CONCAT(nome_token ORDER BY ordem SEPARATOR ' ') AS tokens
              FROM tokens
              JOIN frases ON id_token = id_chave_token
              JOIN tipos_acoes ON id_tipo_acao = id_chave_tipo_acao
              JOIN tipos_resultados AS tr1 ON id_tipo_resultado = tr1.id_chave_tipo_resultado
              JOIN tipos_resultados AS tr2 ON tr1.id_tipo_resultado_pai = tr2.id_chave_tipo_resultado
              GROUP BY id_tipo_acao
              ORDER BY numeracao2, numeracao1";

    $stmt = $conn->prepare($query);
    $stmt->execute();

    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Erro na consulta ao banco de dados: " . $e->getMessage());
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultados da Consulta</title>
    <style>
        body {
            background-color: #121212;
            color: #e0e0e0;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            padding: 20px;
            max-width: 1200px;
            margin: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #333;
        }
        th {
            background-color: #1e1e1e;
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #1a1a1a;
        }
        tr:nth-child(odd) {
            background-color: #2a2a2a;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Resultados da Consulta</h1>

        <?php if (count($results) > 0): ?>
        <table>
            <thead>
                <tr>
                    <th>Numeração 2</th>
                    <th>Nome Tipo Resultado 2</th>
                    <th>Numeração 1</th>
                    <th>Nome Tipo Resultado 1</th>
                    <th>Tokens</th>
                </tr>
            </thead>
            <tbody>
                <?php 
                $last_numeracao1 = null;
                $last_numeracao2 = null;
                foreach ($results as $row): 
                    if ($last_numeracao2 !== $row['numeracao2']): ?>
                        <tr>
                            <td><?= htmlspecialchars($row['numeracao2']) ?></td>
                            <td><?= htmlspecialchars($row['nome_tipo_resultado1']) ?></td>
                            <td colspan="3"></td>
                        </tr>
                    <?php endif;
                    if ($last_numeracao1 !== $row['numeracao1']): ?>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><?= htmlspecialchars($row['numeracao1']) ?></td>
                            <td><?= htmlspecialchars($row['nome_tipo_resultado2']) ?></td>
                            <td></td>
                        </tr>
                    <?php endif; ?>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><?= htmlspecialchars($row['tokens']) ?></td>
                    </tr>
                <?php 
                    $last_numeracao1 = $row['numeracao1'];
                    $last_numeracao2 = $row['numeracao2'];
                endforeach; ?>
            </tbody>
        </table>
        <?php else: ?>
        <p>Nenhum resultado encontrado.</p>
        <?php endif; ?>
    </div>
</body>
</html>

