<?php
include 'php/identifica.cripto.php';

$hash = $_POST['hash'] ?? $_GET['hash'] ?? '';
$device_id = $_POST['device_id'] ?? $_GET['device_id'] ?? '';

header('Content-Type: application/json');

if (!$hash || !$device_id) {
    echo json_encode(['erro' => 'Parâmetros inválidos']);
    exit;
}

$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset("utf8mb4");

// Primeiro, verifica se o hash existe
$stmt_check = $conn->prepare("SELECT hash_mobile FROM usuarios WHERE hash = ?");
$stmt_check->bind_param("s", $hash);
$stmt_check->execute();
$result = $stmt_check->get_result();

if ($row = $result->fetch_assoc()) {
    // Se já está registrado
    if (!empty($row['hash_mobile'])) {
        echo json_encode(['sucesso' => true, 'mensagem' => 'Dispositivo já registrado']);
        $stmt_check->close();
        $conn->close();
        exit;
    }

    $stmt_check->close();

    // Se ainda não está registrado, atualiza
    $stmt_update = $conn->prepare("
        UPDATE usuarios 
        SET 
            hash_mobile = ?,
            tem_local_storage = 'sim',
            data_insercao = CURRENT_TIMESTAMP
        WHERE hash = ? AND (hash_mobile IS NULL OR hash_mobile = '')
    ");
    $stmt_update->bind_param("ss", $device_id, $hash);

    if ($stmt_update->execute()) {
        echo json_encode(['sucesso' => true, 'mensagem' => 'Dispositivo registrado com sucesso']);
    } else {
        echo json_encode(['erro' => 'Erro ao registrar dispositivo: ' . $conn->error]);
    }

    $stmt_update->close();

} else {
    echo json_encode(['erro' => 'Hash inválido']);
}

$conn->close();
?>

