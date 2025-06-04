<?php
include 'database.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

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
WHERE numeracao_tipo_resultado > 0
ORDER BY 
    CAST(SUBSTRING_INDEX(numeracao_tipo_resultado, '.', 1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(numeracao_tipo_resultado, '.', 2), '.', -1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(numeracao_tipo_resultado, '.', 3), '.', -1) AS UNSIGNED);
";

$result = $conn->query($sql);
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
        font-size: 18px; /* Tamanho padrão para desktop */
        line-height: 1.5;
        margin: 0;
        padding: 10px;
    }

    .card {
        background-color: #262626;
        border: 2px solid #00bcd4;
        border-radius: 8px;
        padding: 16px;
        margin: 16px auto;
        max-width: 800px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.5);
    }

    .card-title {
        font-weight: bold;
        font-size: 20px;
        color: #00bcd4;
        margin-bottom: 8px;
    }

    .numeracao {
        font-weight: bold;
        color: #ffd700;
        display: block;
        margin-bottom: 4px;
    }

    .nome {
        display: block;
        margin-bottom: 8px;
    }

    .total {
        font-size: 16px;
        margin-top: 12px;
        color: #ccc;
    }

    a {
        color: #00bcd4;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    /* AUMENTA as fontes no mobile */
    @media (max-width: 768px) {
        body {
            font-size: 32px;
        }

        .card-title {
            font-size: 36px;
        }

        .numeracao {
            font-size: 30px;
        }

        .nome {
            font-size: 28px;        font-size: 2rem;

        }

        .total {
            font-size: 28px;
        }

        a {
            font-size: 30px;
        }
    }
</style>

</head>
<body>

<h2>Consulta de Tipos de Resultados</h2>
<div class="cards">
<?php while ($row = $result->fetch_assoc()) : ?>
    <div class="card">
        <!-- Título -->
        <div class="card-title"><?= htmlspecialchars($row['tipo_resultado_principal']) ?></div>

        <!-- Tipos inferiores -->
        <div class="card-section">
            <?php
            $tipos_resultado_inferior = explode("\n", $row['tipos_resultado_inferior']);
            foreach ($tipos_resultado_inferior as $tipo_resultado) {
                list($numeracao, $nome) = explode(" ", $tipo_resultado, 2);
                echo '<div class="flex-container">';
                echo '<span class="numeracao"><a href="detalhes.php?numeracao_tipo_resultado=' . urlencode($numeracao) . '&nome_tipo_resultado='.urlencode($nome).'" target="_blank">' . htmlspecialchars($numeracao) . '</a></span>';
                echo '<span class="nome">' . htmlspecialchars($nome) . '</span>';
                echo '</div>';
            }
            ?>
        </div>

        <!-- Total de ações -->
        <div class="card-section total">
            Total de tipos de ações: <?= htmlspecialchars($row['total_tipos_acoes']) ?>
        </div>
    </div>
<?php endwhile; ?>
</div>


</body>
</html>

<?php $conn->close(); ?>

