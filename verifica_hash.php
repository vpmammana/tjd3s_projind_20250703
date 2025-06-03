<?php

file_put_contents('log_verifica.txt', json_encode([
    'method' => $_SERVER['REQUEST_METHOD'],
    'POST' => $_POST,
    'GET' => $_GET,
    'raw' => file_get_contents('php://input')
]) . PHP_EOL, FILE_APPEND);

header('Content-Type: application/json');
require_once 'php/identifica.cripto.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Erro de conexão com o banco de dados.'
    ]);
    exit;
}

$hash = $_POST['hash'] ?? $_GET['hash'] ?? '';

if (!$hash) {
    http_response_code(400);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Hash não informado.'
    ]);
    $conn->close();
    exit;
}

$stmt = $conn->prepare("
    SELECT tem_local_storage, u.id_pessoa, p.nome_pessoa, u.nome_usuario, u.hash_mobile
    FROM usuarios u JOIN pessoas p ON id_chave_pessoa=u.id_pessoa
    WHERE hash = ?
");

$stmt->bind_param("s", $hash);
$stmt->execute();
$result = $stmt->get_result();
$data = $result->fetch_assoc();

if ($data) {
    echo json_encode([
        'sucesso' => true,
        'tem_local_storage' => $data['tem_local_storage'] ?? 'nao',
        'id_pessoa' => $data['id_pessoa'],
	'nome_pessoa' => $data['nome_pessoa'],
	'nome_usuario' => $data['nome_usuario']
	'hash_mobile' => $data['hash_mobile']
    ]);
} else {
    http_response_code(404);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Hash inválido ou não encontrado.'
    ]);
}

$stmt->close();
$conn->close();

