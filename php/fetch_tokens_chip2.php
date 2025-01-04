<?php

// // VPM
// include 'database_conecta.php';

// // Habilitar exibição de erros para depuração
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);

// // Function to print executed SQL with bound parameters
// function getExecutedSql($sql, $params)
// {
//     foreach ($params as $param) {
//         $sql = preg_replace('/\?/', is_numeric($param) ? $param : "'$param'", $sql, 1);
//     }
//     return $sql;
// }

// // Validar parâmetros de entrada
// if (!isset($_GET['query']) || !isset($_GET['tokenIndex'])) {
//     echo json_encode(['error' => 'Missing parameters']);
//     exit;
// }

// $query = $_GET['query'];
// $tokenIndex = (int) $_GET['tokenIndex'];
// $previousTokens = isset($_GET['previousTokens']) ? json_decode($_GET['previousTokens']) : [];

// // Construir placeholders para tokens anteriores
// $placeholders = '';
// $params = [$tokenIndex, "(^|[[:space:]])" . $query];
// if (!empty($previousTokens)) {
//     $placeholders = implode(',', array_fill(0, count($previousTokens), '?'));
//     $subphrases = [implode(' ', $previousTokens) . "%"];
//     $subfrases = [implode(' ', $previousTokens) . "%"];
//     $params = array_merge();
// } else {
//     $subfrases = [""];
// }

// // Construir a consulta SQL
// $sql = "
//       SELECT DISTINCT t.nome_token, f.ordem 
//     FROM frases f
//     JOIN tokens t ON t.id_chave_token = f.id_token 
//       AND t.nome_token REGEXP '(^|[[:space:]])'
//      AND f.id_tipo_acao IN (
//               SELECT DISTINCT phrases.id_tipo_acao 
//               FROM 
//             (SELECT id_tipo_acao, group_concat(nome_token order by ordem separator ' ') as phrase
//                 FROM tokens t2, frases f2
//                 WHERE f2.id_token = t2.id_chave_token
//                 GROUP BY f2.id_tipo_acao
//                     ) as phrases
//           )
// ";


// try {
//     // Preparar e executar a consulta
//     $stmt = $conn->query($sql); // Use query instead of prepare/execute

//     error_log("Executed SQL Query 1:\n" . getExecutedSql($sql, $params) . "\n");
//     // Buscar resultados
//     $tokens = $stmt->fetchAll(PDO::FETCH_COLUMN);
//     error_log($tokens . 999);
// } catch (PDOException $e) {
//     // Capturar e exibir erros de consulta
//     echo json_encode(['error' => $e->getMessage()]);
//     exit;
// }

// $sql2 = "SELECT id_tipo_acao, group_concat(nome_token order by ordem separator ' ') as phrase
// 			FROM tokens t2, frases f2
// 			WHERE f2.id_token = t2.id_chave_token
// 			GROUP BY f2.id_tipo_acao
//                         HAVING phrase LIKE ?";

// try {
//     $stmt2 = $conn->prepare($sql2);

//     $stmt2->execute($subfrases);
//     $phrases = $stmt2->fetchAll(PDO::FETCH_ASSOC);
// } catch (PDOException $e) {
//     // Capturar e exibir erros de consulta
//     echo json_encode(['error' => $e->getMessage()]);
//     exit;
// }


// echo json_encode(["tokens" => $tokens, "phrases" => $phrases]);

error_reporting(E_ALL);
ini_set('display_errors', 1);

include "./database.php";
// Scripto para procurar nome_tipo_acao pelo id_tipo_elemento_sintatico = 14 
// Vai pegar os phrases para aguardar no Indexed DB

// Function to print executed SQL with bound parameters
function getExecutedSql($sql, $params)
{
    foreach ($params as $param) {
        $sql = preg_replace('/\?/', is_numeric($param) ? $param : "'$param'", $sql, 1);
    }
    return $sql;
}

// $sql = "
//    SELECT DISTINCT t.nome_token, f.ordem 
//     FROM frases f
//     JOIN tokens t ON t.id_chave_token = f.id_token 
//       WHERE t.nome_token REGEXP '(^|[[:space:]])'
// ";

$sql = "
   SELECT DISTINCT t.nome_token, t.id_chave_token
    FROM tokens t
";

$stmt = $conn->prepare($sql);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $tokens = []; // Inicializa o array para armazenar os resultados

    // Itera pelos resultados e adiciona ao array
    while ($row = $result->fetch_assoc()) {
        $tokens[] = [
            'id_chave_token' => $row['id_chave_token'],
            'nome_token' => $row['nome_token']
        ];
    }

    // Retorna o JSON corretamente codificado
    // echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Query failed: ' . $stmt->error]);
}

$sql2 = "
   SELECT DISTINCT f.ordem, f.id_tipo_acao, f.id_token
    FROM frases f
";

$stmt = $conn->prepare($sql2);

if ($stmt->execute()) {
    $result2 = $stmt->get_result();
    $frases = []; // Inicializa o array para armazenar os resultados

    // Itera pelos resultados e adiciona ao array
    while ($row = $result2->fetch_assoc()) {
        $frases[] = [
            'ordem' => $row['ordem'],
            'id_tipo_acao' => $row['id_tipo_acao'],
            'id_token' => $row['id_token'],
        ];
    }

    // Retorna o JSON corretamente codificado
    // echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    echo json_encode(["tokens" => $tokens, "frases" => $frases]);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Query failed: ' . $stmt->error]);
}

$stmt->close();
$conn->close();
