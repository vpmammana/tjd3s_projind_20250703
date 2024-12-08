<?php

// VPM
include 'database_conecta.php';

// Habilitar exibição de erros para depuração
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Validar parâmetros de entrada
if (!isset($_GET['query']) || !isset($_GET['tokenIndex'])) {
    echo json_encode(['error' => 'Missing parameters']);
    exit;
}

$query = $_GET['query'];
$tokenIndex = (int) $_GET['tokenIndex'];
$previousTokens = isset($_GET['previousTokens']) ? json_decode($_GET['previousTokens']) : [];

// Construir placeholders para tokens anteriores
$placeholders = '';
$params = [$tokenIndex, "(^|[[:space:]])".$query];
if (!empty($previousTokens)) {
    $placeholders = implode(',', array_fill(0, count($previousTokens), '?'));
    $subphrases = [implode(' ', $previousTokens)."%"];
    $subfrases = [implode(' ', $previousTokens)."%"];
    $params = array_merge($params, $subphrases);
}
else {$subfrases=[""];} 

// Construir a consulta SQL
$sql = "
    SELECT DISTINCT t.nome_token 
    FROM frases f
    JOIN tokens t ON t.id_chave_token = f.id_token 
    WHERE f.ordem = ? 
      AND t.nome_token REGEXP ?
";
if (!empty($previousTokens)) {
    $sql .= "
      AND f.id_tipo_acao IN (
          SELECT DISTINCT phrases.id_tipo_acao 
          FROM 
		(SELECT id_tipo_acao, group_concat(nome_token order by ordem separator ' ') as phrase
			FROM tokens t2, frases f2
			WHERE f2.id_token = t2.id_chave_token
			GROUP BY f2.id_tipo_acao
                        HAVING phrase LIKE ?
                ) as phrases
	        
      )
    ";
}


try {
    // Preparar e executar a consulta
    $stmt = $conn->prepare($sql);
    $stmt->execute($params);

    // Buscar resultados
    $tokens = $stmt->fetchAll(PDO::FETCH_COLUMN);
} catch (PDOException $e) {
    // Capturar e exibir erros de consulta
    echo json_encode(['error' => $e->getMessage()]);
    exit;
}

$sql2 = "SELECT id_tipo_acao, group_concat(nome_token order by ordem separator ' ') as phrase
			FROM tokens t2, frases f2
			WHERE f2.id_token = t2.id_chave_token
			GROUP BY f2.id_tipo_acao
                        HAVING phrase LIKE ?";
try {
$stmt2 = $conn->prepare($sql2);
$stmt2->execute($subfrases);
$phrases = $stmt2->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    // Capturar e exibir erros de consulta
    echo json_encode(['error' => $e->getMessage()]);
    exit;
}
    


echo json_encode(["tokens" => $tokens, "phrases" => $phrases]);


?>

