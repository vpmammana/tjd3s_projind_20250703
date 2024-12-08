<?php
// VPM
include 'database_conecta.php';

// Habilitar exibição de erros para depuração
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Validar parâmetros de entrada
if (!isset($_GET['previousTokens'])) {
    echo json_encode(['error' => 'Missing parameters']);
    exit;
}

$previousTokens = isset($_GET['previousTokens']) ? json_decode($_GET['previousTokens']) : [];

// Construir placeholders para tokens anteriores
$placeholders = '';
if (!empty($previousTokens)) {
    $subfrases = [implode(' ', $previousTokens)."%"];
}
else {$subfrases=[""];} 

$sql2 = "
SELECT 
	id_tipo_acao, 
	id_tipo_resultado as id_tipo_resultado_filho, 
	tr2.id_chave_tipo_resultado as id_tipo_resultado_pai, 
	tr1.nome_tipo_resultado as nome_tipo_resultado_filho, 
	tr2.nome_tipo_resultado as nome_tipo_resultado_pai, 
	group_concat(nome_token order by ordem separator ' ') as phrase
FROM 
	tokens t2, 
	frases f2, 
	tipos_resultados tr1, 
	tipos_resultados tr2, 
	tipos_acoes
WHERE 
	f2.id_token = t2.id_chave_token AND 
	f2.id_tipo_acao = id_chave_tipo_acao AND 
	tr1.id_chave_tipo_resultado = id_tipo_resultado AND 
	tr1.id_tipo_resultado_pai = tr2.id_chave_tipo_resultado
GROUP BY 
	f2.id_tipo_acao
                        
HAVING 
	phrase LIKE ? 
ORDER BY 
	id_tipo_resultado, phrase
";
try {
$stmt2 = $conn->prepare($sql2);
$stmt2->execute($subfrases);
$phrases = $stmt2->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    // Capturar e exibir erros de consulta
    echo json_encode(['error' => $e->getMessage()]);
    exit;
}
    


echo json_encode($phrases);


?>

