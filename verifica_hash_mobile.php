<?php
// Configuração de logs detalhados
file_put_contents('log_verifica.txt', date('[Y-m-d H:i:s] ') . json_encode([
    'method' => $_SERVER['REQUEST_METHOD'],
    'ip' => $_SERVER['REMOTE_ADDR'],
    'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? 'N/A',
    'post_data' => $_POST,
    'get_data' => $_GET,
    'raw_input' => file_get_contents('php://input'),
    'request_time' => $_SERVER['REQUEST_TIME_FLOAT']
], JSON_PRETTY_PRINT) . PHP_EOL, FILE_APPEND);

// Headers de segurança
header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: DENY');

// Inclusão segura do arquivo de configuração
require_once __DIR__ . '/php/identifica.cripto.php';

try {
    // Conexão com tratamento de erros
    $conn = new mysqli($servername, $username, $password, $dbname);
    $conn->set_charset("utf8mb4");
    
    if ($conn->connect_error) {
        throw new RuntimeException('Erro de conexão com o banco de dados: ' . $conn->connect_error);
    }

    // Validação do hash
    $hash = trim($_POST['hash'] ?? $_GET['hash'] ?? '');
    if (empty($hash)) {
        throw new InvalidArgumentException('Hash não informado.');
    }

    // Query preparada com JOIN otimizado
    $stmt = $conn->prepare("
        SELECT 
            u.tem_local_storage, 
            u.id_pessoa, 
            p.nome_pessoa, 
            u.nome_usuario, 
            u.hash_mobile,
            u.data_insercao
        FROM usuarios u 
        LEFT JOIN pessoas p ON p.id_chave_pessoa = u.id_pessoa
        WHERE u.hash = ? AND u.data_fim_cadastro IS NULL
        LIMIT 1
    ");
    
    if (!$stmt) {
        throw new RuntimeException('Erro na preparação da query: ' . $conn->error);
    }

    $stmt->bind_param("s", $hash);
    if (!$stmt->execute()) {
        throw new RuntimeException('Erro na execução da query: ' . $stmt->error);
    }

    $result = $stmt->get_result();
    $data = $result->fetch_assoc();

    if (!$data) {
        throw new RuntimeException('Hash inválido ou não encontrado.', 404);
    }

    // Resposta de sucesso
    echo json_encode([
        'sucesso' => true,
        'dados' => [
            'tem_local_storage' => $data['tem_local_storage'] ?? 'nao',
            'id_pessoa' => (int)$data['id_pessoa'],
            'nome_pessoa' => $data['nome_pessoa'],
            'nome_usuario' => $data['nome_usuario'],
            'hash_mobile' => $data['hash_mobile'],
            'ultimo_acesso' => $data['data_insercao']
        ],
        'versao_api' => '1.0.2',
        'timestamp' => time()
    ], JSON_UNESCAPED_UNICODE);

} catch (InvalidArgumentException $e) {
    http_response_code(400);
    echo json_encode([
        'sucesso' => false,
        'erro' => $e->getMessage(),
        'codigo' => 'parametro_invalido'
    ], JSON_UNESCAPED_UNICODE);
    
} catch (RuntimeException $e) {
    $code = $e->getCode() ?: 500;
    http_response_code($code);
    echo json_encode([
        'sucesso' => false,
        'erro' => $e->getMessage(),
        'codigo' => ($code === 404) ? 'nao_encontrado' : 'erro_servidor'
    ], JSON_UNESCAPED_UNICODE);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'sucesso' => false,
        'erro' => 'Erro interno no servidor',
        'codigo' => 'erro_inesperado'
    ], JSON_UNESCAPED_UNICODE);
    
} finally {
    // Garante o fechamento das conexões
    if (isset($stmt)) $stmt->close();
    if (isset($conn)) $conn->close();
}
?>
