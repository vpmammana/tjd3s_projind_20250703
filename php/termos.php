<?php
ob_start();
header('Content-Type: application/json;');
ini_set('display_errors', 0);
error_reporting(0);

include "database.php";

try {
    $termo_lgpd = $_POST['accept'];
    // Insersão de dados de acoes
    $stmt = $conn->prepare("UPDATE pessoas SET termo_lgpd = (?) WHERE id_chave_pessoa = 1");

    if ($stmt === false) {
        throw new Exception('Prepare failed: ' . $conn->error);
    }

    $stmt->bind_param('s', $termo_lgpd);

    if ($stmt->execute()) {
        $terms = 'true';
        if ($termo_lgpd === 'false') {
            $terms = false;
        }
        echo json_encode([
            'success' => true,
            'message' => 'Data received successfully.',
            'terms' => $terms
        ]);
    } else {
        http_response_code(500); // Set HTTP response code for error
        echo json_encode([
            'success' => false,
            'message' => 'Tenta novamente'
        ]);
        exit;
        header("HTTP/1.1 500 Internal Server Error");
    }
} catch (Exception $e) {
    $response['message'] = $e->getMessage();

    http_response_code(500); // Set HTTP response code for error
    echo json_encode([
        'success' => false,
        'message' => 'Tenta novamente'
    ]);
    exit;
    header("HTTP/1.1 500 Internal Server Error");
}

$stmt->close();
$conn->close();

ob_end_flush();
