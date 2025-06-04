<?php
ob_start();

ini_set('display_errors', 0);
ini_set('display_startup_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', __DIR__ . '/php_error.log');
error_reporting(E_ALL);

header('Content-Type: application/json');

$log__file = __DIR__ . '/log.txt';
file_put_contents($log__file, "\n==================== NOVA EXECUCAO ====================\n", FILE_APPEND);

register_shutdown_function(function () {
    $error = error_get_last();
    if ($error && in_array($error['type'], [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR])) {
        file_put_contents(__DIR__ . '/php_error.log', "ERRO FATAL: " . json_encode($error) . "\n", FILE_APPEND);
        http_response_code(500);
        echo json_encode(['success' => false, 'erro' => 'Erro fatal no servidor (shutdown handler).']);
        if (ob_get_length()) {
            ob_end_flush();
        }
    }
});

include "database.php";
include "handleDecrypt.php";

function fallbackLocation(&$lat, &$lon)
{
    if (!$lat || !$lon) {
        $lat = -20.5017;  // Latitude da Ilha de Trindade
        $lon = -29.3222;  // Longitude da Ilha de Trindade
    }
}

try {
    $lon = $_POST['longitude'] ?? null;
    $lat = $_POST['latitude'] ?? null;
    fallbackLocation($lat, $lon);

    $url = "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon";
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'User-Agent: MyCustomUserAgent/1.0',
        'Accept-Language: pt'
    ]);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);

    $mapResponse = curl_exec($ch);

    if (curl_errno($ch) || curl_getinfo($ch, CURLINFO_HTTP_CODE) !== 200) {
        http_response_code(500);
        echo json_encode(['success' => false, 'faceDetected' => false, 'message' => 'Erro de localização']);
        exit;
    }

    curl_close($ch);
    $mapData = json_decode($mapResponse, true);

    $nome_pessoa = $_POST['nome-pessoa'] ?? null;
    $nome_usuario = $_POST['nome-usuario'] ?? null;
    $nomeAtividadeEvento = $_POST['nome-atividade'] ?? null;
    $id_tipo_acao = $_POST['tipo-atividade'] ?? null;
    $data = $_POST['data'] ?? null;
    $descricao = $_POST['atividade-realizada'] ?? null;
    $dataAcao = $_POST['data-acao'] ?? null;
    $horaAcao = $_POST['hora-acao'] ?? null;

    $bounding_box_lat_min = $mapData['boundingbox'][0] ?? null;
    $bounding_box_lat_max = $mapData['boundingbox'][1] ?? null;
    $bounding_box_long_min = $mapData['boundingbox'][2] ?? null;
    $bounding_box_long_max = $mapData['boundingbox'][3] ?? null;
    $neighbourhood = $mapData['address']['municipality'] ?? null;

    if (!$nome_pessoa || !$dataAcao || !$horaAcao || !$nomeAtividadeEvento || !$descricao) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Campos obrigatórios ausentes.']);
        exit;
    }

    $conn = new mysqli($servername, $username, $password, $dbname);
    $conn->set_charset("utf8mb4");
    if ($conn->connect_error) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Erro de conexão com o banco.']);
        exit;
    }

    // Recupera id da pessoa
    $stmt = $conn->prepare("SELECT id_chave_pessoa FROM pessoas WHERE nome_pessoa = ?");
    $stmt->bind_param('s', $nome_pessoa);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $id_pessoa = $row['id_chave_pessoa'] ?? null;
    $stmt->close();

    if (!$id_pessoa) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Pessoa não encontrada.']);
        exit;
    }

    // Atividade evento
    $stmt = $conn->prepare("INSERT INTO atividades_eventos (nome_atividade_evento, data_atividade_evento, hora_atividade_evento, id_usuario) VALUES (?, ?, ?, (SELECT id_chave_usuario FROM usuarios WHERE id_pessoa = ?))");
    $stmt->bind_param('sssi', $nomeAtividadeEvento, $dataAcao, $horaAcao, $id_pessoa);
    $stmt->execute();
    $id_atividade_evento = $conn->insert_id;
    $stmt->close();

    // Endereço e localização
    $stmt = $conn->prepare("INSERT INTO enderecos (bairro, latitude, longitude) VALUES (?, ?, ?)");
    $stmt->bind_param('sdd', $neighbourhood, $lat, $lon);
    $stmt->execute();
    $id_endereco = $conn->insert_id;
    $stmt->close();

    $stmt = $conn->prepare("INSERT INTO localizacoes (id_endereco, bbox_lat_min, bbox_lat_max, bbox_long_min, bbox_long_max) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param('idddd', $id_endereco, $bounding_box_lat_min, $bounding_box_lat_max, $bounding_box_long_min, $bounding_box_long_max);
    $stmt->execute();
    $id_localizacao = $conn->insert_id;
    $stmt->close();

    // Upload e tipo do arquivo
    $arquivo = $_FILES['files']['name'][0] ?? null;
    $extensao = pathinfo($arquivo, PATHINFO_EXTENSION);

    $stmt = $conn->prepare("SELECT id_chave_tipo_arquivo FROM tipos_arquivos WHERE extensao = ?");
    $stmt->bind_param('s', $extensao);
    $stmt->execute();
    $res = $stmt->get_result();
    $row = $res->fetch_assoc();
    $id_tipo_arquivo = $row['id_chave_tipo_arquivo'] ?? null;
    $stmt->close();

    $caminho_arquivo_original = '/caminho/original';
    $caminho_arquivo_anonimizado = '/caminho/anonimizado';
    $quantidade_pessoas = 0;

    $stmt = $conn->prepare("INSERT INTO arquivos (nome_arquivo, id_tipo_arquivo, caminho_arquivo_original, quantidade_pessoas, caminho_arquivo_anonimizado) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param('sisis', $arquivo, $id_tipo_arquivo, $caminho_arquivo_original, $quantidade_pessoas, $caminho_arquivo_anonimizado);
    $stmt->execute();
    $id_arquivo = $conn->insert_id;
    $stmt->close();

    // Ação
    $stmt = $conn->prepare("INSERT INTO acoes (id_atividade_evento, id_localizacao, id_tipo_acao, id_arquivo, latitude, longitude, data_acao, hora_acao, descricao, id_pessoa, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT id_chave_usuario FROM usuarios WHERE id_pessoa = ?))");
    $stmt->bind_param('iiiiddsssii', $id_atividade_evento, $id_localizacao, $id_tipo_acao, $id_arquivo, $lat, $lon, $dataAcao, $horaAcao, $descricao, $id_pessoa, $id_pessoa);
    $stmt->execute();
    $stmt->close();

    // Chamada ao script Python (mock)
    $python = escapeshellcmd("/var/www/html/venv/bin/python3 /var/www/html/php/pasteur.py " . escapeshellarg($caminho_arquivo_original));
    $output = shell_exec($python);
    file_put_contents($log__file, "\nPYTHON OUTPUT:\n$output\n", FILE_APPEND);

    echo json_encode(['success' => true, 'message' => 'Dados gravados com sucesso.']);

    $conn->close();
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}

$conteudo_ob_ = ob_get_contents();
file_put_contents('saida_ob.txt', $conteudo_ob_, FILE_APPEND | LOCK_EX);
ob_end_flush();

