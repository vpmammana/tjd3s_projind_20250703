<?php
include 'php/identifica.cripto.php';


$hash = $_POST['hash'] ?? $_GET['hash'] ?? '';
$device_id = $_POST['device_id'] ?? $_GET['device_id'] ?? '';

header('Content-Type: application/json');

if (!$hash || !$device_id) {
    echo json_encode(['valid' => false, 'erro' => 'Parâmetros inválidos']);
    exit;
}

$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset("utf8mb4");

$stmt = $conn->prepare("
    SELECT 1 
    FROM usuarios 
    WHERE hash = ? AND hash_mobile = ? AND data_fim_cadastro IS NULL
");
$stmt->bind_param("ss", $hash, $device_id);
$stmt->execute();
$result = $stmt->get_result();

echo json_encode([
    'valid' => $result->num_rows > 0
]);

$stmt->close();
$conn->close();
?>
