<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include "./database_conecta.php";

$stmt = $conn->prepare("SELECT id_chave_tipo_acao, id_tipo_resultado FROM tipos_acoes WHERE id_tipo_elemento_sintatico = 14 AND id_tipo_resultado IS NOT NULL;");

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $data = []; // Inicializa o array para armazenar os resultados

    // Itera pelos resultados e adiciona ao array
    while ($row = $result->fetch_assoc()) {
        $data[] = [
            'id_chave_tipo_acao' => $row['id_chave_tipo_acao'],
            'id_tipo_resultado' => $row['id_tipo_resultado']
        ];
    }

    // Retorna o JSON corretamente codificado
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Query failed: ' . $stmt->error]);
}

// Fecha o statement e a conexão
$stmt->close();
$conn->close();
