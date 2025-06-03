<?php
header('Content-Type: application/json');

// Relatório de erros
error_reporting(E_ALL);
ini_set('display_errors', 0); // não exibe erros na tela

// Tratamento de erro fatal
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

// Credenciais
require_once 'php/identifica.cripto.php';

// Captura do parâmetro via POST ou GET
$hash = $_POST['hash'] ?? $_GET['hash'] ?? '';

if (!$hash) {
    http_response_code(400);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Parâmetro "hash" não fornecido.'
    ]);
    exit;
}

// Conexão com o banco
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Erro ao conectar ao banco de dados: ' . $conn->connect_error
    ]);
    exit;
}

$conn->set_charset("utf8mb4");

// Prepara a query
$stmt = $conn->prepare("
    UPDATE usuarios 
    SET 
        tem_local_storage = 'nao',
        hash_mobile = NULL 
    WHERE hash = ?
");

if (!$stmt) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Erro ao preparar a query SQL: ' . $conn->error
    ]);
    $conn->close();
    exit;
}

$stmt->bind_param("s", $hash);

// Executa a query
if (!$stmt->execute()) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Erro ao executar atualização: ' . $stmt->error
    ]);
    $stmt->close();
    $conn->close();
    exit;
}

// Verifica resultado
if ($stmt->affected_rows > 0) {
    echo json_encode([
        'sucesso' => true,
        'mensagem' => 'Registro de dispositivo removido com sucesso.'
    ]);
} else {
    echo json_encode([
        'sucesso' => true,
        'mensagem' => 'Nenhuma alteração: o hash não existia, já estava limpo ou não houve mudança.'
    ]);
}

// Fecha conexão
$stmt->close();
$conn->close();

