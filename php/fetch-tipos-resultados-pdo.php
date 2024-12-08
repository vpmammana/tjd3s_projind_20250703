<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include "./database_conecta.php";

try {
    // Prepara e executa a consulta
//    $stmt = $conn->prepare("
//        SELECT 
//            f.id_chave_tipo_resultado AS id_chave_tipo_resultado, 
//            p.nome_tipo_resultado AS nome_tipo_resultado_pai, 
//            f.numeracao_tipo_resultado AS numeracao_tipo_resultado, 
//            f.nome_tipo_resultado AS nome_tipo_resultado_filho,
//	    f.id_tipo_resultado_pai AS id_tipo_resultado_pai,
//	    f.id_chave_tipo_resultado AS id_tipo_resultado_filho 
//        FROM 
//            tipos_resultados f, 
//            tipos_resultados p 
//        WHERE 
//            f.id_tipo_resultado_pai = p.id_chave_tipo_resultado;
//    ");

    $stmt = $conn->prepare("
	SELECT 
		f.id_chave_tipo_resultado as id_chave_tipo_resultado, 
		f.id_tipo_resultado_pai as id_tipo_resultado_pai,
		p.nome_tipo_resultado as nome_tipo_resultado_pai, 
		f.numeracao_tipo_resultado as numeracao_tipo_resultado, 
		f.nome_tipo_resultado as nome_tipo_resultado_filho 
	from 
		tipos_resultados f, 
		tipos_resultados p 
	where 
		f.id_tipo_resultado_pai = p.id_chave_tipo_resultado 
union 
	select 
		m.id_chave_tipo_resultado as id_chave_tipo_resultado, 
		m.id_tipo_resultado_pai as id_tipo_resultado_pai,
		m.nome_tipo_resultado as nome_tipo_resultado_pai, 
		m.numeracao_tipo_resultado as numeracao_tipo_resultado, 
		m.nome_tipo_resultado as nome_tipo_resultado_filho  
	from 
		tipos_resultados as m 
	where 
		id_tipo_resultado_pai is null;
    ");


    $stmt->execute();

    // Obtém os resultados como um array associativo
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Retorna o JSON corretamente codificado
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Query failed: ' . $e->getMessage()]);
}

// Fecha a conexão (opcional, pois o PHP fecha automaticamente no fim do script)
$conn = null;
?>
