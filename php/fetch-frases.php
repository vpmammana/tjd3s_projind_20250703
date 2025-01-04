<?php
//VPM

error_reporting(E_ALL);
ini_set('display_errors', 1);

include "./database.php";

$stmt = $conn->prepare("select id_chave_frase, id_token, ordem, id_tipo_acao from frases;");

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $data = []; // Inicializa o array para armazenar os resultados

    // Itera pelos resultados e adiciona ao array
    while ($row = $result->fetch_assoc()) {
        $data[] = [
            'id_chave_frase' => $row['id_chave_frase'],
            'id_token' => $row['id_token'],
            'ordem' => $row['ordem'],
            'id_tipo_acao' => $row['id_tipo_acao']
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
