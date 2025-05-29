<?php
include 'php/identifica.cripto.php';

$hash = $_GET['hash'] ?? '';

header('Content-Type: application/json');

if (!$hash) {
    echo json_encode(['erro' => 'hash ausente']);
    exit;
}

$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset("utf8mb4");

$stmt = $conn->prepare("SELECT tem_local_storage FROM usuarios WHERE hash = ?");
$stmt->bind_param("s", $hash);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode([
        'tem_local_storage' => $row['tem_local_storage']
    ]);
} else {
    echo json_encode(['erro' => 'usuário não encontrado']);
}
$stmt->close();
$conn->close();

