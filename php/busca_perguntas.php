<?php
header('Content-Type: application/json');

include 'database_conecta.php';

try {
    $query = "
	SELECT id_chave_pergunta, nome_pergunta, placeholder, help
	FROM perguntas;
    ";
    $stmt = $conn->prepare($query);
    $stmt->execute();

    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($result);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>

