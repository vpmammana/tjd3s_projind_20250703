<?php
ob_start();
header('Content-Type: application/json');
ini_set('display_errors', 0);
error_reporting(0);

include "database.php";

try {
    // Verifica se os parâmetros necessários estão presentes
    if (!isset($_POST['accept']) || !isset($_POST['id_pessoa'])) {
        throw new Exception('Parâmetros "accept" e "id_pessoa" são obrigatórios.');
    }

    $termo_lgpd = $_POST['accept'];
    $id_pessoa = intval($_POST['id_pessoa']); // Garante que seja um número inteiro

    // Prepara a query de atualização
    $stmt = $conn->prepare("UPDATE pessoas SET termo_lgpd = ? WHERE id_chave_pessoa = ?");

    if ($stmt === false) {
        throw new Exception('Erro no prepare: ' . $conn->error);
    }

    $stmt->bind_param('si', $termo_lgpd, $id_pessoa);

    if ($stmt->execute()) {
        $terms = ($termo_lgpd === 'true');
        echo json_encode([
            'success' => true,
            'message' => 'Dados atualizados com sucesso.',
            'terms' => $terms
        ]);
    } else {
        throw new Exception('Erro ao executar a atualização.');
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}

if (isset($stmt) && $stmt !== false) {
    $stmt->close();
}
$conn->close();
ob_end_flush();

