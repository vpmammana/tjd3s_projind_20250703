<?php
require_once "identifica.cripto.php";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) die("Erro na conexão: " . $conn->connect_error);

$outfile = "recupera_dados_atividades_eventos.sql";
$f = fopen($outfile, "w");
fwrite($f, "-- Gerado em " . date('Y-m-d H:i:s') . "\n\n");

// ATIVIDADES_EVENTOS
$sql = "SELECT ae.nome_atividade_evento, ae.data_atividade_evento, ae.hora_atividade_evento, u.nome_usuario
        FROM atividades_eventos ae
        LEFT JOIN usuarios u ON u.id_chave_usuario = ae.id_usuario";
$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $nome = addslashes($row['nome_atividade_evento']);
    $data = $row['data_atividade_evento'];
    $hora = $row['hora_atividade_evento'];
    $usuario = addslashes($row['nome_usuario']);
    $usuario_subquery = $usuario ? "(SELECT id_chave_usuario FROM usuarios WHERE nome_usuario = '$usuario')" : "NULL";
    fwrite($f, "INSERT INTO atividades_eventos (nome_atividade_evento, data_atividade_evento, hora_atividade_evento, id_usuario) VALUES ('$nome', " . ($data ? "'$data'" : "NULL") . ", " . ($hora ? "'$hora'" : "NULL") . ", $usuario_subquery);\n");
}

// USUARIOS
$sql = "SELECT nome_usuario, email, data_inicio_cadastro FROM usuarios u LEFT JOIN pessoas p ON p.id_chave_pessoa = u.id_pessoa";
$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $usuario = addslashes($row['nome_usuario']);
    $email = addslashes($row['email']);
    $data_inicio = $row['data_inicio_cadastro'];
    $hash = hash('sha256', 'usuarios_de_fato_no_ato' . $usuario);
    fwrite($f, "INSERT INTO usuarios (nome_usuario, senha, hash, data_inicio_cadastro, id_pessoa) VALUES ('$usuario', '', '$hash', '$data_inicio', (SELECT id_chave_pessoa FROM pessoas WHERE email = '$email'));\n");
}

// LOCALIZACOES
$sql = "SELECT latitude, longitude, display_name, city, state, country FROM localizacoes";
$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $lat = $row['latitude'];
    $lon = $row['longitude'];
    $display = addslashes($row['display_name']);
    $city = addslashes($row['city']);
    $state = addslashes($row['state']);
    $country = addslashes($row['country']);
    fwrite($f, "INSERT INTO localizacoes (latitude, longitude, display_name, city, state, country) VALUES ($lat, $lon, '$display', '$city', '$state', '$country');\n");
}

// ENDERECOS
$sql = "SELECT e.id_localizacao, i.nome_instituicao FROM enderecos e LEFT JOIN instituicoes i ON e.id_instituicao = i.id_chave_instituicao";
$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $inst = addslashes($row['nome_instituicao']);
    $loc = $row['id_localizacao'];
    fwrite($f, "INSERT INTO enderecos (id_instituicao, id_localizacao) VALUES ((SELECT id_chave_instituicao FROM instituicoes WHERE nome_instituicao = '$inst'), (SELECT id_chave_localizacao FROM localizacoes WHERE id_chave_localizacao = $loc));\n");
}

// ACOES
$sql = "SELECT 
  a.data_acao, a.hora_acao, a.latitude, a.longitude, a.descricao,
  ae.nome_atividade_evento, u.nome_usuario, l.display_name,
  p.email, ta.nome_tipo_acao, arq.nome_arquivo
FROM acoes a
LEFT JOIN atividades_eventos ae ON ae.id_chave_atividade_evento = a.id_atividade_evento
LEFT JOIN usuarios u ON u.id_chave_usuario = a.id_usuario
LEFT JOIN localizacoes l ON l.id_chave_localizacao = a.id_localizacao
LEFT JOIN pessoas p ON p.id_chave_pessoa = a.id_pessoa
LEFT JOIN tipos_acoes ta ON ta.id_chave_tipo_acao = a.id_tipo_acao
LEFT JOIN arquivos arq ON arq.id_chave_arquivo = a.id_arquivo";
$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $data = $row['data_acao'];
    $hora = $row['hora_acao'];
    $lat = $row['latitude'] ?? "NULL";
    $lon = $row['longitude'] ?? "NULL";
    $descricao = addslashes($row['descricao']);
    $atividade = addslashes($row['nome_atividade_evento']);
    $usuario = addslashes($row['nome_usuario']);
    $localizacao = addslashes($row['display_name']);
    $email = addslashes($row['email']);
    $tipo_acao = addslashes($row['nome_tipo_acao']);
    $arquivo = addslashes($row['nome_arquivo']);

    fwrite($f, "INSERT INTO acoes (id_atividade_evento, id_usuario, id_localizacao, id_tipo_acao, id_arquivo, latitude, longitude, data_acao, hora_acao, descricao, id_pessoa) VALUES (
        (SELECT id_chave_atividade_evento FROM atividades_eventos WHERE nome_atividade_evento = '$atividade'),
        (SELECT id_chave_usuario FROM usuarios WHERE nome_usuario = '$usuario'),
        (SELECT id_chave_localizacao FROM localizacoes WHERE display_name = '$localizacao'),
        (SELECT id_chave_tipo_acao FROM tipos_acoes WHERE nome_tipo_acao = '$tipo_acao'),
        (SELECT id_chave_arquivo FROM arquivos WHERE nome_arquivo = '$arquivo'),
        $lat, $lon, '$data', '$hora', '$descricao',
        (SELECT id_chave_pessoa FROM pessoas WHERE email = '$email'));\n");
}

fclose($f);
$conn->close();
echo "✅ Script salvo em $outfile\n";

