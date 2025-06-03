<?php

ob_start(); // Captura a saída, inclusive avisos e erros

// Evita que o erro apareça para quem chamou via navegador/Apache
ini_set('display_errors', 0);
ini_set('display_startup_errors', 1);

// Garante que os erros continuem sendo registrados no log do PHP
ini_set('log_errors', 1);
ini_set('error_log', __DIR__ . '/php_error.log'); // Salvar log perto do script
error_reporting(E_ALL);

// Configura o Content-Type como JSON (opcional)
header('Content-Type: application/json;');

$log__file = 'log.txt';
$log__Message = "Início de transação em " . date('Y-m-d H:i:s') . "\n";

$projectRoot = dirname(__DIR__);
$pythonPath = '/var/www/html/venv/bin/python';
$scriptPath = $projectRoot . '/php/pasteur.py';

file_put_contents($log__file, "\n\n===========================================================================\n", FILE_APPEND | LOCK_EX);
file_put_contents($log__file, $log__Message."\n", FILE_APPEND | LOCK_EX);

include "database.php";
include "handleDecrypt.php";
file_put_contents($log__file, "MSG: POST Data: " . json_encode($_POST) . "\n", FILE_APPEND | LOCK_EX);

$response = ['success' => false, 'message' => ''];
function log_request_data()
{
    $logData = [
        'POST' => $_POST,
        'FILES' => $_FILES
    ];

    $logDataJson = json_encode($logData, JSON_PRETTY_PRINT);
    file_put_contents($log__file, "\nMSG: LogData:".$logDataJson."\n",  FILE_APPEND | LOCK_EX);
    error_log($logDataJson);
}

// log_request_data();
try {
    $lon = $_POST['longitude'];
    $lat = $_POST['latitude'];

    $url = "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon";
    file_put_contents($log__file, "\nMSG: Consulta ao nominatim: ".$url."\n", FILE_APPEND | LOCK_EX);
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, $url);

    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        'User-Agent: MyCustomUserAgent/1.0',
        'Accept-Language: pt'
    ));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);

    curl_setopt($ch, CURLOPT_TIMEOUT, 10);

    $mapResponse = curl_exec($ch);

    file_put_contents($log__file,  "MSG: mapResponse: ".$mapResponse . "\n", FILE_APPEND | LOCK_EX);

    if (curl_errno($ch)) {
        http_response_code(500); // Set HTTP response code for error
        echo json_encode([
            'success' => false,
            'faceDetected' => 'false',
            'message' => 'Erro de localização'
        ]);
	file_put_contents($log__file,  "\n".'ERRO: Erro de localização - saindo' . "\n", FILE_APPEND | LOCK_EX);
        exit;
    }

    $http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ($http_status !== 200) {
	file_put_contents($log__file,  "\n".'ERRO: Erro de localização - status: ' . $http_status . " Vou sair \n", FILE_APPEND | LOCK_EX);
        echo json_encode([
            'success' => false,
            'faceDetected' => 'false',
            'message' => 'Erro de localização'
        ]);
        exit;
    }
    file_put_contents($log__file,  "CHECK: Passou exits\n", FILE_APPEND | LOCK_EX);

    curl_close($ch);
    file_put_contents($log__file,  "CHECK: passou curl\n", FILE_APPEND | LOCK_EX);

    // variables used to capture request data from frontend
    $mapData = json_decode($mapResponse, true);
 file_put_contents($log__file,  "CHECK: passou json decode\n", FILE_APPEND | LOCK_EX);


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
    file_put_contents($log__file,  "CHECK: passou bounding box\n", FILE_APPEND | LOCK_EX);
    $neighbourhood = $mapData['address']['municipality'] ?? null;
    $country = $mapData['address']['country'] ?? null;
    $road = $mapData['address']['road'] ?? null;
    $city = $mapData['address']['city'] ? $mapData['address']['city'] : $mapData['address']['city_district'] ?? null;
    $state = $mapData['address']['state'] ?? null;
    $postCode = $mapData['address']['postcode'] ?? null;
    $countryCode = strtoupper($mapData['address']['country_code']);
    $suburb = $mapData['address']['suburb'] ?? null;
    $dislayName = $mapData['display_name'] ?? null;
    $address = $mapData['address'] ?? null;
    file_put_contents($log__file,  "CHECK: passou address\n", FILE_APPEND | LOCK_EX);
    $id_pais = 0;
    file_put_contents($log__file,  "CHECK: passou id_pais\n", FILE_APPEND | LOCK_EX);
    $id_estado = 0;
    file_put_contents($log__file,  "CHECK: passou id_estado\n", FILE_APPEND | LOCK_EX);
    $nome_estado = '';
    file_put_contents($log__file,  "CHECK: passou nome_estado\n", FILE_APPEND | LOCK_EX);
    $id_cidade = 0;
    file_put_contents($log__file,  "CHECK: passou id_cidade\n", FILE_APPEND | LOCK_EX);
    $codigo_ibge = 0;
    file_put_contents($log__file,  "CHECK: passou codigo_ibge\n", FILE_APPEND | LOCK_EX);
    $id_localizacao = 0;
    file_put_contents($log__file,  "CHECK: passou id_localizacao\n", FILE_APPEND | LOCK_EX);
    $id_endereco = 0;
    file_put_contents($log__file,  "CHECK: passou id_endereco\n", FILE_APPEND | LOCK_EX);
    $id_atividade_evento = 0;
    file_put_contents($log__file,  "CHECK: passou id_atividade_evento\n", FILE_APPEND | LOCK_EX);
    $id_arquivo = 0;
    file_put_contents($log__file,  "CHECK: passou id_arquivo\n", FILE_APPEND | LOCK_EX);
    $id_tipo_arquivo = 0;
    file_put_contents($log__file,  "CHECK: passou id_tipo_arquivo\n", FILE_APPEND | LOCK_EX);
    $id_pessoa = 0;
   
    // procure o id_chave_pessoa pelo nome_pessoa

file_put_contents($log__file, "CHECK: passou atribuições", FILE_APPEND | LOCK_EX);


    $log_message = "[" . date('Y-m-d H:i:s') . "] "
    . "Pessoa: $nome_pessoa, "
    . "Usuário: $nome_usuario, "
    . "Atividade: $nomeAtividadeEvento, "
    . "Tipo de Ação: $id_tipo_acao, "
    . "Data: $data, "
    . "Descrição: $descricao, "
    . "Data da Ação: $dataAcao, "
    . "Hora da Ação: $horaAcao\n";
    file_put_contents($log__file, "MSG: ".$log_message, FILE_APPEND | LOCK_EX);

    $stmt = $conn->prepare("SELECT id_chave_pessoa FROM pessoas WHERE nome_pessoa = ?");

    if ($stmt === false) {
        throw new Exception('Prepare failed: ' . $conn->error);
    }

    $stmt->bind_param('s', $nome_pessoa);
file_put_contents($log__file, "SQL: SELECT id_chave_pessoa FROM pessoas WHERE nome_pessoa = '$nome_pessoa'", FILE_APPEND | LOCK_EX);

    if ($stmt->execute()) {
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);

        if (!empty($data)) {
            $id_pessoa = $data[0]['id_chave_pessoa'];
        } else {
            http_response_code(500); // Set HTTP response code for error
	    file_put_contents($log__file, "ERRO: Usuário não existe. FIM.", FILE_APPEND | LOCK_EX);
            echo json_encode([
                'success' => false,
                'faceDetected' => 'false',
                'message' => 'Usuario não existe por favor contato o administrador'
            ]);
            exit;
        }
    } else {
        $response['message'] = $e->getMessage();
    }

    // procure o id_chave_pais pelo nome_pais
    $stmt = $conn->prepare("SELECT id_chave_pais FROM paises where nome_pais = ?");
    $stmt->bind_param('s', $country);
    file_put_contents($log__file, "SQL: SELECT id_chave_pais FROM paises where nome_pais = $country\n", FILE_APPEND | LOCK_EX);
    if ($stmt === false) {
    file_put_contents($log__file, "ERRO: prepare failed. Execução INTERROMPIDA.\n", FILE_APPEND | LOCK_EX);
	
        throw new Exception('Prepare failed: ' . $conn->error);
    }


    if ($stmt->execute()) {
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        if (!empty($data)) {
            $id_pais = $data[0]['id_chave_pais'];
        }
    } else {
	    file_put_contents($log__file, "\nERRO: stmt->execute não vingou: ".$e->getMessage()."\n", FILE_APPEND | LOCK_EX);

        $response['message'] = $e->getMessage();
    }

    // procure o id_chave_estado pelo nome_estado
    $stmt = $conn->prepare("SELECT id_chave_estado, nome_estado FROM estados WHERE nome_estado =  ?");
    file_put_contents($log__file, "SQL: SELECT id_chave_estado, nome_estado FROM estados WHERE nome_estado = $state", FILE_APPEND | LOCK_EX);
    $stmt->bind_param('s', $state);
    if ($stmt->execute()) {
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        if (!empty($data)) {
            $id_estado = $data[0]['id_chave_estado'];
            $nome_estado = $data[0]['nome_estado'];
        }
    } else {
        $error_message = 'Query failed: ' . $stmt->error;
	file_put_contents($log__file,  "\n".'ERRO: ' . $error_message . "\n", FILE_APPEND | LOCK_EX);

        echo json_encode(['error' => $error_message]);
    }

    // procureos dados de cidade pelo id_estado e o nome_cidade
    $stmt = $conn->prepare("SELECT * FROM cidades WHERE id_estado =  ? AND nome_cidade = ?");
file_put_contents($log__file,  "\n"."SQL: SELECT * FROM cidades WHERE id_estado =  $id_estado AND nome_cidade = $city", FILE_APPEND | LOCK_EX); 
    if ($stmt === false) {
file_put_contents($log__file,  "\n".'ERRO: ' . $conn->error . "\n", FILE_APPEND | LOCK_EX);
        throw new Exception('Prepare failed: ' . $conn->error);
    }

    $stmt->bind_param('is', $id_estado, $city);

    if ($stmt->execute()) {

        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        if (!empty($data)) {
            $id_cidade = $data[0]['id_chave_cidade'];
        }
    } else {
	file_put_contents($log__file,  "ERRO: queru failed: $e->getMessage()", FILE_APPEND | LOCK_EX);
        error_log('Query failed: ' . $e->getMessage());
    }

    // insersão de dados de localização com os dados do Mapa e o id_estado, id_cidade e id_pais
    $stmt = $conn->prepare("INSERT INTO localizacoes (latitude, longitude, bounding_box_lat_min, bounding_box_lat_max, bounding_box_long_min, bounding_box_long_max, display_name, road, neighbourhood, suburb, city, state, postcode, country, country_code, id_cidade, id_estado, id_pais) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
file_put_contents($log__file,  "\nSQL: INSERT INTO localizacoes (latitude, longitude, bounding_box_lat_min, bounding_box_lat_max, bounding_box_long_min, bounding_box_long_max, display_name, road, neighbourhood, suburb, city, state, postcode, country, country_code, id_cidade, id_estado, id_pais) VALUES ($lon, $lat, $bounding_box_lat_min, $bounding_box_lat_max, $bounding_box_long_min, $bounding_box_long_max, $dislayName, $road, $neighbourhood, $suburb, $city, $state, $postCode, $country, $countryCode, $id_cidade, $id_estado, $id_pais)\n", FILE_APPEND | LOCK_EX);
    if ($stmt === false) {
 	file_put_contents($log__file,  "\n".'ERRO: ' . $conn->error . "\n", FILE_APPEND | LOCK_EX);
        throw new Exception('Prepare failed: ' . $conn->error);
    }


    $stmt->bind_param('ddddddsssssssssiii', $lon, $lat, $bounding_box_lat_min, $bounding_box_lat_max, $bounding_box_long_min, $bounding_box_long_max, $dislayName, $road, $neighbourhood, $suburb, $city, $state, $postCode, $country, $countryCode, $id_cidade, $id_estado, $id_pais);

    if ($stmt->execute()) {
        $id_localizacao = $conn->insert_id;
    } else {
	file_put_contents($log__file, "\nErro: query failed: $e->getMessage()", FILE_APPEND | LOCK_EX);
        error_log('Query failed: ' . $e->getMessage());
    }

    // insersão de id_localizacao para a tabela de  enderecos
    $stmt = $conn->prepare("INSERT INTO enderecos (id_localizacao) VALUES (?)");
file_put_contents($log__file, "SQL: INSERT INTO enderecos (id_localizacao) VALUES ($conn->error)",  FILE_APPEND | LOCK_EX);
    if ($stmt === false) {
	file_put_contents($log__file, "\nERRO: prepare failed:".$conn->error,  FILE_APPEND | LOCK_EX);
        throw new Exception('Prepare failed: ' . $conn->error);
    }

    $stmt->bind_param('i', $id_localizacao);

    if ($stmt->execute()) {
        $id_endereco = $conn->insert_id;
    } else {
	file_put_contents($log__file, "ERRO: Query failed: $e->getMessage()",  FILE_APPEND | LOCK_EX);    
        error_log('Query failed: ' . $e->getMessage());
    }

    // insercão de dados atividades_eventos, data_atividade_evento, hora_atividade_evento  para a tabela de atividades_eventos
    $stmt = $conn->prepare("INSERT INTO atividades_eventos (nome_atividade_evento, data_atividade_evento, hora_atividade_evento, id_usuario) VALUES (?,?,?,(select id_chave_usuario from usuarios where id_pessoa=(select id_chave_pessoa from pessoas where nome_pessoa = ?)))");
file_put_contents($log__file, "SQL: INSERT INTO atividades_eventos (nome_atividade_evento, data_atividade_evento, hora_atividade_evento, id_usuario) VALUES ($nomeAtividadeEvento,$dataAcao, $horaAcao,(select id_chave_usuario from usuarios where id_pessoa=(select id_chave_pessoa from pessoas where nome_pessoa =$nome_pessoa )))" ,  FILE_APPEND | LOCK_EX);
    if ($stmt === false) {
file_put_contents($log__file, "\nERRO: Prepare failed:$conn->error", FILE_APPEND | LOCK_EX);
        throw new Exception('Prepare failed: ' . $conn->error);
    }

    $stmt->bind_param('ssss', $nomeAtividadeEvento, $dataAcao, $horaAcao, $nome_pessoa);

    if ($stmt->execute()) {
        $id_atividade_evento = $conn->insert_id;
    } else {
	file_put_contents($log__file, "\nERRO: Query failed:$e->getMessage()", FILE_APPEND | LOCK_EX);
        error_log('Query failed: ' . $e->getMessage());
    }

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        try {
            // Verifica se o diretoria de uploads existe
            function handleFileUploads($fileInputName)
            {
                global $fileExtension;
                global $quantidade_pessoas;
                global $caminho_arquivo_anonimizado;
                global $caminho_arquivo_original;
                global $nome_arquivo;
		global $log__file;
		global $pythonPath;
		global $scriptPath;
                $lockFile = "../locks/pasteur.lock";

                if (isset($_FILES[$fileInputName]) && is_array($_FILES[$fileInputName]['name'])) {
                    foreach ($_FILES[$fileInputName]['name'] as $key => $name) {
			file_put_contents($log__file,  'MSG: nome_file: ' . $name . "\n", FILE_APPEND | LOCK_EX);
                        if ($_FILES[$fileInputName]['error'][$key] == UPLOAD_ERR_OK) {
			    file_put_contents($log__file, "CHECK: UPLOAD_ERR_OK\n", FILE_APPEND | LOCK_EX);
                            // Verifica se tem um lockfile que é usado quando tem um arquivo sendo processado.
                            while (file_exists($lockFile)) {
				file_put_contents($log__file,  'ERRO:  Waiting for previous instance to finish...' . "\n", FILE_APPEND | LOCK_EX);

                                error_log("Waiting for previous instance to finish...");
                                sleep(10);
                            }

                            // Cria o Lockfile para prevenir outras instancias
                            file_put_contents($lockFile, '');

                            // Gerenciar processo de carregar arquivo o output.json vai pegar os dados de procesamento de imagem
                            file_put_contents('output.json', '');

                            $fileTmpPath = $_FILES[$fileInputName]['tmp_name'][$key];
                            $fileExtension = pathinfo($name, PATHINFO_EXTENSION);
                            $fileName = uniqid(rand(), true) . '.' . $fileExtension;
                            //$destinationPath = "../imagem/input/" . $fileName;

$destinationDir = realpath(__DIR__ . '/../imagem/input');
if ($destinationDir === false) {
    file_put_contents($log__file, "ERRO: Destino inválido ->". $destinationDir."\n", FILE_APPEND | LOCK_EX);
    throw new Exception('Destino de imagem inválido.');
}

$destinationPath = $destinationDir . '/' . $fileName;
			    file_put_contents($log__file, "MSG: destinationPath: " . $destinationPath,  FILE_APPEND | LOCK_EX);
                            error_log("destinationPath: " . $destinationPath);


                            if (!move_uploaded_file($fileTmpPath, $destinationPath)) {
				file_put_contents($log__file,  'ERRO: Error moving uploaded file: ' . $name . " ou ".$fileTmpPath." / ".$destinationPath. "\n", FILE_APPEND | LOCK_EX);
                                throw new Exception('Error moving uploaded file.');
                            }

                            // Comanda de Python usado para fazer o processamento de imagem
//                            $command = escapeshellcmd("/var/www/html/venv/bin/python /var/www/html/php/pasteur.py") . ' ' . escapeshellarg($destinationPath). ' 2>&1';
$command = escapeshellcmd("$pythonPath $scriptPath") . ' ' . escapeshellarg($destinationPath);
file_put_contents($log__file,  "\nMSG: Comando: " . $command . "\n", FILE_APPEND | LOCK_EX);
                            $output = [];
                            $returnVar = 0;
                            exec($command, $output, $returnVar);
                                file_put_contents($log__file, "\nSaida de erros do python:  ".implode("\n",$output), FILE_APPEND | LOCK_EX  );

                            if ($returnVar !== 0) {
                                // Empty the 'imagem/input' folder
                                $files = glob('../imagem/input/*'); // Get all file names
                                foreach ($files as $file) {
					file_put_contents($log__file,  'MSG: Deletando arquivo: ' . $file . "\n", FILE_APPEND | LOCK_EX);
                                    if (is_file($file)) {
                                        unlink($file); // Delete each file
                                    }
                                }
                                unlink($lockFile);
				file_put_contents($log__file, "\nERRO: Command failed with error code: $returnVar\n",  FILE_APPEND | LOCK_EX);

                                error_log("Command failed with error code: $returnVar");
                                header("HTTP/1.1 500 Internal Server Error");
                            }
                            //Pegar os dados de processamento de imagemns
                            $output = file_get_contents('output.json');
			    file_put_contents($log__file, "\nMSG: output.json:".$output."\n", FILE_APPEND | LOCK_EX);
                            if ($output === false) {
				file_put_contents($log__file, "\nERRO: Failed to read output.json\n", FILE_APPEND | LOCK_EX);
                                error_log("Failed to read output.json");
                            } else {
				file_put_contents($log__file, "\nOutput nao eh false. Vai tentar encript. ", FILE_APPEND | LOCK_EX  );
                                // formatar e configurar os dados de processamneto de imagem
                                $jsonOutput = json_decode($output, true);
                                error_log(json_encode($jsonOutput));
                                $quantidade_pessoas = intval($jsonOutput['quantidade_pessoas']);
                                $caminho_arquivo_anonimizado = $jsonOutput['caminho_arquivo_anonimizado'];
                                $encryptKey = "tjd3s_s3djttjd3s";
                                $iv = "tjd3s_s3djttjd3s";
                                $caminho_arquivo_original = handleDecrypt($jsonOutput['caminho_arquivo_original'], $encryptKey, $iv);
                                $nome_arquivo = $jsonOutput['nome_arquivo'];

                                if (json_last_error() !== JSON_ERROR_NONE) {
				    file_put_contents($log__file, "\nERRO: JSON Decode Error:\n",  FILE_APPEND | LOCK_EX);
                                    error_log("JSON Decode Error: " . json_last_error_msg());
                                    throw new Exception("JSON Decode Error: " . json_last_error_msg());
                                } else {
                                    $jsonString = json_encode($jsonOutput);
                                }
                            }

                            if ($returnVar !== 0) {
				file_put_contents($log__file, "\nERRO: Python script execution failed:\n",  FILE_APPEND | LOCK_EX);
                                throw new Exception("Error: Python script execution failed.");
                            } else {
				file_put_contents($log__file, "\nCHECK: Python script executed successfully.\n",  FILE_APPEND | LOCK_EX);
                                error_log("Python script executed successfully.");
                            }

                            // Remove the lock file
                            unlink($lockFile);
                        } else {
			    file_put_contents($log__file,  'ERRO: Error uploading file "' . htmlspecialchars($name) . '": ' . getUploadErrorMessage($_FILES[$fileInputName]['error'][$key]) . "\n", FILE_APPEND | LOCK_EX);
                            throw new Exception('Error uploading file "' . htmlspecialchars($name) . '": ' . getUploadErrorMessage($_FILES[$fileInputName]['error'][$key]));
                        }
                    }
                }
            }





            function getUploadErrorMessage($errorCode)
            {
                switch ($errorCode) {
                    case UPLOAD_ERR_INI_SIZE:
                    case UPLOAD_ERR_FORM_SIZE:
                        return 'File size exceeds the allowed limit.';
                    case UPLOAD_ERR_PARTIAL:
                        return 'File was only partially uploaded.';
                    case UPLOAD_ERR_NO_FILE:
                        return 'No file was uploaded.';
                    default:
                        return 'Unknown upload error.';
                }
            }
            handleFileUploads('files');
        } catch (Exception $e) {
	    file_put_contents($log__file, "ERRO: Erro de processamento de imagem. " . "\n", FILE_APPEND | LOCK_EX);
            http_response_code(500); // Set HTTP response code for error
            echo json_encode([
                'success' => false,
                'faceDetected' => 'false',
                'message' => 'Erro de processamento de imagem'
            ]);
            exit;
        }
    }

file_put_contents($log__file, "CHECK: Passou o tratamento de imagens: " . "\n", FILE_APPEND | LOCK_EX);


    $extensao  = '.' . $fileExtension;
    // Procure o id_chave_tipo_arquivo pela extensao
    $stmt = $conn->prepare("SELECT id_chave_tipo_arquivo FROM tipos_arquivos WHERE extensao = ?");
file_put_contents($log__file, "SQL: SELECT id_chave_tipo_arquivo FROM tipos_arquivos WHERE extensao = $extensao" . "\n", FILE_APPEND | LOCK_EX);
    if ($stmt === false) {
	file_put_contents($log__file, "\nERRO: Prepare failed\n", FILE_APPEND | LOCK_EX);
        throw new Exception('Prepare failed: ' . $conn->error);
    }

    $stmt->bind_param('s', $extensao);

    if ($stmt->execute()) {
        $result = $stmt->get_result();

        $data = $result->fetch_all(MYSQLI_ASSOC);

        if (!empty($data)) {
            $id_tipo_arquivo = $data[0]['id_chave_tipo_arquivo'];
            error_log('id_tipo_arquivo: ' . $id_tipo_arquivo);
        } else {
            http_response_code(500); // Set HTTP response code for error
            echo json_encode([
                'success' => false,
                'extensionError' => 'false',
                'message' => 'Arquivos do  tipo ' . $extensao . ' não é suportado'
            ]);
            exit;
        }
    } else {
        error_log('Query failed: ' . $e->getMessage());
    }
file_put_contents($log__file, "SQL: SELECT id_chave_tipo_arquivo FROM tipos_arquivos WHERE extensao = $extensao " . "\n", FILE_APPEND | LOCK_EX);

    // Insersão de dados da tabela arquivos
    $stmt = $conn->prepare("INSERT INTO arquivos (nome_arquivo, id_tipo_arquivo, caminho_arquivo_original, quantidade_pessoas, caminho_arquivo_anonimizado) VALUES (?, ?, ?, ?, ?)");
file_put_contents($log__file, "SQL: INSERT INTO arquivos (nome_arquivo, id_tipo_arquivo, caminho_arquivo_original, quantidade_pessoas, caminho_arquivo_anonimizado) VALUES ($nome_arquivo, $id_tipo_arquivo, $caminho_arquivo_original, $quantidade_pessoas, $caminho_arquivo_anonimizado)", FILE_APPEND | LOCK_EX);
    if ($stmt === false) {
	    file_put_contents($log__file, "ERRO: HTTP/1.1 500 Internal Server Error", FILE_APPEND | LOCK_EX);
        header("HTTP/1.1 500 Internal Server Error");
    }

    $stmt->bind_param('sisis', $nome_arquivo, $id_tipo_arquivo, $caminho_arquivo_original, $quantidade_pessoas, $caminho_arquivo_anonimizado);

    if ($stmt->execute()) {
        $id_arquivo = $conn->insert_id;
    } else {
	    file_put_contents($log__file, "\nERRO: Query failed\n", FILE_APPEND | LOCK_EX);
        error_log('Query failed: ' . $e->getMessage());
    }

    // Insersão de dados de acoes
    $stmt = $conn->prepare("INSERT INTO acoes (id_atividade_evento, id_localizacao, id_tipo_acao, id_arquivo, latitude, longitude, data_acao, hora_acao, descricao, id_pessoa, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (select id_chave_usuario from usuarios where id_pessoa = ?))");

    if ($stmt === false) {
	file_put_contents($log__file, "\nERRO: INSERT INTO acoes (id_atividade_evento, id_localizacao, id_tipo_acao, id_arquivo, latitude, longitude, data_acao, hora_acao, descricao, id_pessoa, id_usuario) VALUES ($id_atividade_evento, $id_localizacao, $id_tipo_acao, $id_arquivo, $lat, $lon, $dataAcao, $horaAcao, $descricao, $id_pessoa, (select id_chave_usuario from usuarios where id_pessoa = $id_pessoa))", FILE_APPEND | LOCK_EX);
        throw new Exception('Prepare failed: ' . $conn->error);
    }

    $stmt->bind_param('iiiiddsssii', $id_atividade_evento, $id_localizacao, $id_tipo_acao, $id_arquivo, $lat, $lon, $dataAcao, $horaAcao, $descricao, $id_pessoa, $id_pessoa);

    if ($stmt->execute()) {
        $response = [
            'success' => true,
            'message' => 'Data submitted successfully'
        ];
        echo json_encode($response);
    } else {
	    file_put_contents($log__file, "\nERRO: Query failed\n", FILE_APPEND | LOCK_EX);
        error_log('Query failed: ' . $e->getMessage());
    }
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
    if (curl_errno($ch)) {
	                file_put_contents($log__file, "\nERRO: Erro de Localização\n", FILE_APPEND | LOCK_EX);
        http_response_code(500); // Set HTTP response code for error
        echo json_encode([
            'success' => false,
            'faceDetected' => 'false',
            'message' => 'Erro de localização'
        ]);
        exit;
    }
    header("HTTP/1.1 500 Internal Server Error");
}



$stmt->close();
$conn->close();
file_put_contents($log__file, "CHECK: fechou o conn: " . "\n", FILE_APPEND | LOCK_EX);

$conteudo_ob_ = ob_get_contents(); // Apenas pega, sem limpar
file_put_contents('saida_ob.txt', $conteudo_ob_, FILE_APPEND | LOCK_EX);

ob_end_flush();
