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
    GROUP_CONCAT(t.nome_token ORDER BY f.ordem SEPARATOR ' ') AS frase_final,
    GROUP_CONCAT(DISTINCT arq.nome_arquivo) as nome_arquivo,
    GROUP_CONCAT(DISTINCT city) as cidade,
    GROUP_CONCAT(DISTINCT ac.descricao) as descricao,
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
LEFT JOIN localizacoes loca ON id_chave_localizacao = ac.id_localizacao
GROUP BY 
    ae.id_chave_atividade_evento
ORDER BY 
    ae.data_insercao DESC
";


// Executar a query
$result = $conn->query($sql);
if (!$result) {
    die("Erro na query: " . $conn->error);
}

// HTML básico
echo "<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Atividades</title></head><body>";
echo "<h1>Atividades e Frases</h1>";

while ($row = $result->fetch_assoc()) {
    echo "<div style='margin-bottom:30px;'>";
    echo "<h2>" . htmlspecialchars($row['nome_atividade_evento']) . "</h2>";
    echo "<p><strong>Frase:</strong> " . htmlspecialchars($row['frase_final']) . "</p>";
    echo "<p><strong>Descricao:</strong> " . htmlspecialchars($row['descricao']) . "</p>";
    // Posição da primeira ocorrência
$texto = $row['local'];
$pos = strpos($texto, 'Região Geográfica');

if ($pos !== false) {
    $texto_truncado = substr($texto, 0, $pos);
} else {
    $texto_truncado = $texto; // ou vazio, ou outro comportamento
}
$texto_truncado = preg_replace('/[\s,]+$/', '', $texto_truncado);
    echo "<p><strong>Local:</strong> " . htmlspecialchars($texto_truncado) . "</p>";
    echo "<p><strong>Cidade:</strong> " . htmlspecialchars($row['cidade']) . "</p>";
    
    // Exibir imagem se houver
    if (!empty($row['nome_arquivo'])) {
        $img_path = "../imagem/pasteur/" . urlencode($row['nome_arquivo']); // ajuste conforme seu sistema
        echo $img_path;
        echo "<img src='$img_path' alt='Imagem' style='max-width:300px; display:block; margin-top:10px;'>";
    }

    echo "</div>";
}

echo "</body></html>";

// Fechar conexão
$conn->close();
?>

