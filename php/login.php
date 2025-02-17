<?php
ob_start();
header('Content-Type: application/json;');
ini_set('display_errors', 0);
error_reporting(0);

include "database.php";

try {
    $usuario = $_POST['usuario'];
    $senha = $_POST['senha'];

    if (!$usuario || !$senha) {
        http_response_code(400); // Set HTTP response code for error
        echo json_encode([
            'success' => false,
            'type' => 'access_failure'
        ]);
        exit;
    }
    $stmt = $conn->prepare("SELECT nome_usuario, senha, nome_pessoa FROM usuarios u INNER JOIN pessoas p on u.id_pessoa = p.id_chave_pessoa WHERE nome_usuario = ?");

    if ($stmt === false) {
        throw new Exception('Prepare failed: ' . $conn->error);
    }

    $stmt->bind_param('s', $usuario);

    if ($stmt->execute()) {
        $result = $stmt->get_result();

        $data = $result->fetch_all(MYSQLI_ASSOC);

        if ($senha !== $data[0]['senha']) {
            http_response_code(400); // Set HTTP response code for error

            echo json_encode([
                'success' => false,
                'type' => 'access_failure'
            ]);
            exit;
        }
        $nome_usuario = $data[0]['nome_usuario'];
        $nome_pessoa = $data[0]['nome_pessoa'];


        echo json_encode([
            'success' => true,
            'message' => 'Data received successfully.',
            'nome_usuario' => $nome_usuario,
            'nome_pessoa' => $nome_pessoa
        ]);
    } else {
        http_response_code(400); // Set HTTP response code for error
        echo json_encode([
            'success' => false,
            'type' => 'access_failure'
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
