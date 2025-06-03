<?php
include 'identifica.cripto.php';

$hash = $_POST['hash'] ?? '';
$hash_mobile = $_POST['hash_mobile'] ?? '';

header('Content-Type: application/json');

if (!$hash || !$hash_mobile) {
    echo json_encode(['erro' => 'Parâmetros ausentes']);
    exit;
}

$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset("utf8mb4");

// Atualiza hash_mobile apenas se o hash principal for válido
$stmt = $conn->prepare("
    UPDATE usuarios 
    SET hash_mobile = ?, tem_local_storage = 'sim'
    WHERE hash = ?
");
$stmt->bind_param("ss", $hash_mobile, $hash);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        echo json_encode(['sucesso' => true]);
    } else {
        echo json_encode(['erro' => 'Hash não encontrado ou já atualizado']);
    }
} else {
    echo json_encode(['erro' => 'Erro ao atualizar: ' . $conn->error]);
}

$stmt->close();
$conn->close();
?>
