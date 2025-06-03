<?php
header('Content-Type: application/json');

// Garante que todos erros sejam exibidos no log
error_reporting(E_ALL);
ini_set('display_errors', 0);

// Garante flush da resposta mesmo em caso de erro fatal
register_shutdown_function(function () {
    $last_error = error_get_last();
    if ($last_error && in_array($last_error['type'], [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR])) {
        http_response_code(500);
        echo json_encode([
            'sucesso' => false,
            'erro' => 'Erro fatal no servidor.'
        ]);
    }
});

require_once 'php/identifica.cripto.php'; // define $servername, $username, $password, $dbname

$hash = $_POST['hash'] ?? '';

if (!$hash) {
    http_response_code(400);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Hash não fornecido.'
    ]);
    exit;
}

// Conecta ao banco
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Erro de conexão com o banco de dados.'
    ]);
    exit;
}

// Atualiza apenas se tem_local_storage for 'nao'
$stmt = $conn->prepare("
    UPDATE usuarios 
    SET tem_local_storage = 'sim' 
    WHERE hash = ? AND tem_local_storage = 'nao'
");

if (!$stmt) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Erro ao preparar a query.'
    ]);
    $conn->close();
    exit;
}

$stmt->bind_param("s", $hash);

if (!$stmt->execute()) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Erro ao executar atualização.'
    ]);
    $stmt->close();
    $conn->close();
    exit;
}

if ($stmt->affected_rows > 0) {
    echo json_encode([
        'sucesso' => true,
        'mensagem' => 'Atualizado com sucesso.'
    ]);
} else {
    echo json_encode([
        'sucesso' => false,
        'mensagem' => 'Hash já estava atualizado ou não encontrado.'
    ]);
}

$stmt->close();
$conn->close();

