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

register_shutdown_function(function () use ($log__file) {
    $error = error_get_last();
    if ($error && in_array($error['type'], [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR])) {
        file_put_contents(__DIR__ . '/php_error.log', "ERRO FATAL: " . json_encode($error) . "\n", FILE_APPEND);
        file_put_contents($log__file, "ERRO FATAL: " . json_encode($error) . "\n", FILE_APPEND);
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
        $lat = -20.5017;
        $lon = -29.3222;
    }
}

function handleFileUpload(string $log__file): array
{
    $arquivo = $_FILES['files']['name'][0] ?? null;
    $tmpPath = $_FILES['files']['tmp_name'][0] ?? null;

    if (!$arquivo || !$tmpPath || !is_uploaded_file($tmpPath)) {
        file_put_contents($log__file, "ERRO: Arquivo inválido ou não enviado\n", FILE_APPEND);
        throw new Exception('Arquivo inválido ou não enviado.');
    }

    $uploadDir = __DIR__ . '/../imagem/input/';
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
        file_put_contents($log__file, "CRIADO DIRETÓRIO: $uploadDir\n", FILE_APPEND);
    }

    $destino = realpath($uploadDir) . '/' . basename($arquivo);
//    $destino = $uploadDir . '/' . basename($arquivo);
    if (!move_uploaded_file($tmpPath, $destino)) {
        file_put_contents($log__file, "ERRO: Falha ao mover o arquivo para $destino\n", FILE_APPEND);
        throw new Exception('Falha ao mover o arquivo enviado.');
    }

    file_put_contents($log__file, "UPLOAD: $arquivo salvo em $destino\n", FILE_APPEND);

    return [
        'nome' => $arquivo,
        'caminho' => $destino
    ];
}

try {
    $lon = $_POST['longitude'] ?? null;
    $lat = $_POST['latitude'] ?? null;
    file_put_contents($log__file, "COORDENADAS: lat=$lat, lon=$lon\n", FILE_APPEND);
//    fallbackLocation($lat, $lon);
    file_put_contents($log__file, "COORDENADAS: lat=$lat, lon=$lon\n", FILE_APPEND);

    $url = "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon";
    file_put_contents($log__file, "URL MAPA: $url\n", FILE_APPEND);

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
    file_put_contents($log__file, "MAP RESPONSE: $mapResponse\n", FILE_APPEND);

    if (curl_errno($ch) || curl_getinfo($ch, CURLINFO_HTTP_CODE) !== 200) {
        file_put_contents($log__file, "ERRO: Falha ao obter localização\n", FILE_APPEND);
        http_response_code(500);
        echo json_encode(['success' => false, 'faceDetected' => false, 'message' => 'Erro de localização']);
        exit;
    }
    curl_close($ch);
    $mapData = json_decode($mapResponse, true);

    $nome_usuario = $_POST['nome-usuario'] ?? null;
    $nome_pessoa = $_POST['nome-pessoa'] ?? null;
    $nomeAtividadeEvento = $_POST['nome-atividade'] ?? null;
    $id_tipo_acao = $_POST['tipo-atividade'] ?? null;
    $descricao = $_POST['atividade-realizada'] ?? null;
    $dataAcao = $_POST['data-acao'] ?? null;
    $horaAcao = $_POST['hora-acao'] ?? null;

    $bounding_box_lat_min = $mapData['boundingbox'][0] ?? null;
    $bounding_box_lat_max = $mapData['boundingbox'][1] ?? null;
    $bounding_box_long_min = $mapData['boundingbox'][2] ?? null;
    $bounding_box_long_max = $mapData['boundingbox'][3] ?? null;

    $display_name = $mapData['display_name'] ?? '';
    $road = $mapData['address']['road'] ?? null;
    $neighbourhood = $mapData['address']['neighbourhood'] ?? null;
    $suburb = $mapData['address']['suburb'] ?? null;
    $city = $mapData['address']['city'] ?? null;
    $state = $mapData['address']['state'] ?? null;
    $postcode = $mapData['address']['postcode'] ?? null;
    $country = $mapData['address']['country'] ?? null;
    $country_code = $mapData['address']['country_code'] ?? null;

    $conn = new mysqli($servername, $username, $password, $dbname);
    $conn->set_charset("utf8mb4");
    if ($conn->connect_error) {
        file_put_contents($log__file, "ERRO: Conexão com o banco falhou: {$conn->connect_error}\n", FILE_APPEND);
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Erro de conexão com o banco.']);
        exit;
    }

    file_put_contents($log__file, "BUSCANDO PESSOA: $nome_pessoa\n", FILE_APPEND);
    $stmt = $conn->prepare("SELECT id_chave_pessoa FROM pessoas WHERE nome_pessoa = ?");
    $stmt->bind_param('s', $nome_pessoa);
    $stmt->execute();
    $result = $stmt->get_result();
    $id_pessoa = $result->fetch_assoc()['id_chave_pessoa'] ?? null;
    $stmt->close();

    if (!$id_pessoa) {
        file_put_contents($log__file, "ERRO: Pessoa não encontrada\n", FILE_APPEND);
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Pessoa não encontrada.']);
        exit;
    }

    $stmt = $conn->prepare("INSERT INTO atividades_eventos (nome_atividade_evento, data_atividade_evento, hora_atividade_evento, id_usuario) VALUES (?, ?, ?, (SELECT id_chave_usuario FROM usuarios WHERE nome_usuario = ?))");
    $stmt->bind_param('ssss', $nomeAtividadeEvento, $dataAcao, $horaAcao, $nome_usuario);
    $stmt->execute();
    $id_atividade_evento = $conn->insert_id;
    $stmt->close();
    file_put_contents($log__file, "INSERT ATIVIDADE_EVENTO ID: $id_atividade_evento\n", FILE_APPEND);

    file_put_contents($log__file, "COORDENADAS antes do prepare: lat=$lat, lon=$lon\n", FILE_APPEND);
    $stmt = $conn->prepare("INSERT INTO localizacoes (latitude, longitude, bounding_box_lat_min, bounding_box_lat_max, bounding_box_long_min, bounding_box_long_max, display_name, road, neighbourhood, suburb, city, state, postcode, country, country_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    file_put_contents($log__file, "COORDENADAS depois do prepare: lat=$lat, lon=$lon\n", FILE_APPEND);

    $stmt->bind_param('ddddddsssssssss', $lat, $lon, $bounding_box_lat_min, $bounding_box_lat_max, $bounding_box_long_min, $bounding_box_long_max, $display_name, $road, $neighbourhood, $suburb, $city, $state, $postcode, $country, $country_code);
    $stmt->execute();
    $id_localizacao = $conn->insert_id;
    $stmt->close();
    file_put_contents($log__file, "INSERT LOCALIZACAO ID: $id_localizacao\n", FILE_APPEND);

    $uploadInfo = handleFileUpload($log__file);
    $arquivo = $uploadInfo['nome'];
    $caminho_arquivo_original = $uploadInfo['caminho'];
    $caminho_arquivo_anonimizado = $caminho_arquivo_original;
    $quantidade_pessoas = 0;

    $extensao = ".". pathinfo($arquivo, PATHINFO_EXTENSION);
    $stmt = $conn->prepare("SELECT id_chave_tipo_arquivo FROM tipos_arquivos WHERE extensao = ?");
    $stmt->bind_param('s', $extensao);
    $stmt->execute();
    $id_tipo_arquivo = $stmt->get_result()->fetch_assoc()['id_chave_tipo_arquivo'] ?? null;
    $stmt->close();
    file_put_contents($log__file, "TIPO ARQUIVO ID: $id_tipo_arquivo (ext: $extensao)\n", FILE_APPEND);



    $python_script = realpath(__DIR__ . '/pasteur.py');
    $python = escapeshellcmd("/var/www/html/venv/bin/python3 " . $python_script . " " . escapeshellarg($caminho_arquivo_original));

    // $python = escapeshellcmd("/var/www/html/venv/bin/python3 /var/www/html/php/pasteur.py " . escapeshellarg($caminho_arquivo_original));
    shell_exec($python);
    $output = file_get_contents('output.json');
    file_put_contents($log__file, "\nPYTHON CMD: $python\nPYTHON OUTPUT:\n$output\n", FILE_APPEND);
    $data_pasteur = json_decode($output, true);

$quantidade_pessoas_pasteur = $data_pasteur['quantidade_pessoas'] ?? null;
$caminho_arquivo_anonimizado_pasteur = $data_pasteur['caminho_arquivo_anonimizado'] ?? null;
$caminho_arquivo_original_pasteur = $data_pasteur['caminho_arquivo_original'] ?? null;
$nome_arquivo_pasteur = $data_pasteur['nome_arquivo'] ?? null;

    $stmt = $conn->prepare("INSERT INTO arquivos (nome_arquivo, id_tipo_arquivo, caminho_arquivo_original, quantidade_pessoas, caminho_arquivo_anonimizado) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param('sisis', $nome_arquivo_pasteur, $id_tipo_arquivo, $caminho_arquivo_original_pasteur, $quantidade_pessoas_pasteur, $caminho_arquivo_anonimizado_pasteur);
    $stmt->execute();
    $id_arquivo = $conn->insert_id;
    $stmt->close();
    file_put_contents($log__file, "INSERT ARQUIVO ID: $id_arquivo\n", FILE_APPEND);

    $stmt = $conn->prepare("INSERT INTO acoes (id_atividade_evento, id_localizacao, id_tipo_acao, id_arquivo, latitude, longitude, data_acao, hora_acao, descricao, id_pessoa, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT id_chave_usuario FROM usuarios WHERE nome_usuario = ?))");
    $stmt->bind_param('iiiiddsssis', $id_atividade_evento, $id_localizacao, $id_tipo_acao, $id_arquivo, $lat, $lon, $dataAcao, $horaAcao, $descricao, $id_pessoa, $nome_usuario);
    $stmt->execute();
    $stmt->close();
    file_put_contents($log__file, "INSERT ACAO executado com sucesso\n", FILE_APPEND);


    echo json_encode(['success' => true, 'message' => 'Dados gravados com sucesso.']);
    $conn->close();

} catch (Exception $e) {
    file_put_contents($log__file, "ERRO EXCECAO: " . $e->getMessage() . "\n", FILE_APPEND);
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}

$conteudo_ob_ = ob_get_contents();
file_put_contents('saida_ob.txt', $conteudo_ob_, FILE_APPEND | LOCK_EX);
ob_end_flush();

