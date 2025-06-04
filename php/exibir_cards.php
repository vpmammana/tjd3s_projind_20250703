<?php
// Conexão segura
include('identifica.cripto.php');

// Criar conexão
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Consulta SQL
$sql = "
SELECT 
    ae.nome_atividade_evento,
    ae.data_insercao,
    GROUP_CONCAT(t.nome_token ORDER BY f.ordem SEPARATOR ' ') AS frase_final,
    GROUP_CONCAT(DISTINCT arq.nome_arquivo) as nome_arquivo,
    GROUP_CONCAT(DISTINCT city) as cidade,
    GROUP_CONCAT(DISTINCT ac.descricao) as descricao,
    GROUP_CONCAT(DISTINCT usu.nome_usuario) as nome_usuario,
    GROUP_CONCAT(DISTINCT display_name) as local
FROM 
    atividades_eventos ae
JOIN 
    acoes ac ON ac.id_atividade_evento = ae.id_chave_atividade_evento
LEFT JOIN 
    frases f ON f.id_tipo_acao = ac.id_tipo_acao
LEFT JOIN 
    tokens t ON f.id_token = t.id_chave_token
LEFT JOIN 
    arquivos arq ON ac.id_arquivo = arq.id_chave_arquivo
LEFT JOIN 
    localizacoes loca ON id_chave_localizacao = ac.id_localizacao
LEFT join usuarios usu ON ae.id_usuario = id_chave_usuario
GROUP BY 
    ae.id_chave_atividade_evento
ORDER BY 
    ae.data_insercao DESC
";

$result = $conn->query($sql);
if (!$result) {
    die("Erro na query: " . $conn->error);
}

// HTML + estilo CSS
echo "<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Atividades</title>
<style>
    body {
        font-family: sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 1000px;
        margin: 20px auto;
        padding: 10px;
    }
    .card {
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 16px;
        margin-bottom: 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        max-height: 33vh;
        overflow-y: auto;
    }
    .card h2 {
        font-weight: bold;
        margin: 0 0 6px 0;
    }
    .card .data-insercao {
        font-size: 0.9em;
        color: #666;
        margin-bottom: 10px;
    }
    .card img {
        display: block;
        max-width: 100%;
        max-height: 20vh;
        height: auto;
        object-fit: contain;
        margin: 12px auto;
        border-radius: 4px;
    }
    .card p {
        margin: 6px 0;
    }
    @media (max-width: 768px) {
        .container {
            padding: 5px;
        }
        .card {
            margin: 10px 5px;
        }
    }
</style>
</head><body><div class='container'>";

echo "<h1>Atividades e Frases</h1>";

while ($row = $result->fetch_assoc()) {
    echo "<div class='card'>";

    // Título
    echo "<h2>" . htmlspecialchars($row['nome_atividade_evento']) . "</h2>";

    // Data
    echo "<div class='data-insercao'>" . htmlspecialchars($row['data_insercao']) . "</div>";
    echo "<div class='data-insercao'>" . htmlspecialchars($row['nome_usuario']) . "</div>";

    // Imagem (opcional)
    if (!empty($row['nome_arquivo'])) {
        $img_path = "../imagem/pasteur/" . urlencode($row['nome_arquivo']);
        echo "<img src='$img_path' alt='Imagem da atividade'>";
    }

    // Frase
    echo "<p><strong>Frase:</strong> " . htmlspecialchars($row['frase_final']) . "</p>";

    // Descrição
    echo "<p><strong>Descrição:</strong> " . htmlspecialchars($row['descricao']) . "</p>";

    // Local (truncado)
    $texto = $row['local'];
    $pos = strpos($texto, 'Região Geográfica');
    $texto_truncado = ($pos !== false) ? substr($texto, 0, $pos) : $texto;
    $texto_truncado = preg_replace('/[\s,]+$/', '', $texto_truncado);
    echo "<p><strong>Local:</strong> " . htmlspecialchars($texto_truncado) . "</p>";

    // Cidade
    echo "<p><strong>Cidade:</strong> " . htmlspecialchars($row['cidade']) . "</p>";

    echo "</div>"; // .card
}

echo "</div></body></html>";

$conn->close();
?>

