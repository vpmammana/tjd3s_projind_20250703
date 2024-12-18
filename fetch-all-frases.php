<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include "./php/database.php";
// Scripto para procurar nome_tipo_acao pelo id_tipo_elemento_sintatico = 14 
// Vai pegar os phrases para aguardar no Indexed DB


$sql = "
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
ORDER BY 
	id_tipo_resultado, phrase
";

$stmt = $conn->prepare($sql);

if ($stmt->execute()) {
	$result = $stmt->get_result();
	$data = []; // Inicializa o array para armazenar os resultados

	// Itera pelos resultados e adiciona ao array
	while ($row = $result->fetch_assoc()) {
		$data[] = [
			'id_tipo_acao' => $row['id_tipo_acao'],
			'nome_tipo_resultado_pai' => $row['nome_tipo_resultado_pai'],
			'phrase' => $row['phrase']
		];
	}

	// Retorna o JSON corretamente codificado
	echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
} else {
	http_response_code(500);
	echo json_encode(['error' => 'Query failed: ' . $stmt->error]);
}

$stmt->close();
$conn->close();
