<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include "./database_conecta.php";

$stmt = $conn->prepare("SELECT f.id_chave_tipo_resultado as id_chave_tipo_resultado, p.nome_tipo_resultado as nome_tipo_resultado_pai, f.numeracao_tipo_resultado as numeracao_tipo_resultado, f.nome_tipo_resultado as nome_tipo_resultado_filho from tipos_resultados f, tipos_resultados p where f.id_tipo_resultado_pai = p.id_chave_tipo_resultado  or id_tipo_resultado_pai is NULL ;");

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $data = []; // Inicializa o array para armazenar os resultados

    // Itera pelos resultados e adiciona ao array
    while ($row = $result->fetch_assoc()) {
        $data[] = [
            'id_chave_tipo_resultado' => $row['id_chave_tipo_resultado'],
            'nome_tipo_resultado_pai' => $row['nome_tipo_resultado_pai'],
            'numeracao_tipo_resultado' => $row['numeracao_tipo_resultado'],
            'nome_tipo_resultado_filho' => $row['nome_tipo_resultado_filho']
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
