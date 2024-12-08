<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);                 

include "./database_conecta.php";

try {
    // Prepara e executa a consulta
    $stmt = $conn->prepare("SELECT id_chave_token, nome_token, id_tipo_token, id_tipo_flexao FROM tokens;");
    $stmt->execute();

    // Obtém os resultados como um array associativo
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Retorna o JSON corretamente codificado
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Query failed: ' . $e->getMessage()]);
}

// Fecha a conexão (opcional, pois o PHP fecha automaticamente no fim do script)
$conn = null;
?>

