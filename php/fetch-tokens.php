<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include "./database.php";

$stmt = $conn->prepare("select id_chave_token, nome_token, id_tipo_token, id_tipo_flexao from tokens;");

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $data = []; // Inicializa o array para armazenar os resultados

    // Itera pelos resultados e adiciona ao array
    while ($row = $result->fetch_assoc()) {
            $data[] = [
            'id_chave_token' => $row['id_chave_token'],
            'nome_token' => $row['nome_token'],
            'id_tipo_token' => $row['id_tipo_token'],
            'id_tipo_flexao' => $row['id_tipo_flexao']
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
