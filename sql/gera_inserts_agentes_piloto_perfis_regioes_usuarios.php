<?php

if ($argc < 3) {
    echo "Uso:\n";
    echo "  php csv_to_sql_pessoas_com_fk_inserts.php entrada.csv saida.sql\n\n";
    echo "Descrição:\n";
    echo "  Lê CSV separado por '|', usa os campos Perfil|Nome |E-mail|Telefone|Região de Atuação.\n";
    echo "  Mapeia perfis específicos para tipos_vinculos e gera inserts únicos nas tabelas.\n";
    exit(1);
}

$inputFile = $argv[1];
$outputFile = $argv[2];

if (!file_exists($inputFile)) {
    die("Erro: arquivo de entrada '$inputFile' não encontrado.\n");
}

$handle = fopen($inputFile, 'r');
if (!$handle) {
    die("Erro ao abrir o arquivo CSV.\n");
}

$header = fgetcsv($handle, 0, '|');
$header = array_map('trim', $header);

$idx_perfil    = array_search('Perfil', $header);
$idx_nome      = array_search('Nome', $header);
$idx_email     = array_search('E-mail', $header);
$idx_telefone  = array_search('Telefone', $header);
$idx_regiao    = array_search('Região de Atuação', $header);
$idx_manda_msg = array_search('Pode mandar mensagem', $header);

if (in_array(false, [$idx_perfil, $idx_nome, $idx_email, $idx_telefone, $idx_regiao, $id_manda_msg], true)) {
    die("Erro: cabeçalhos obrigatórios não encontrados (Perfil, Nome, E-mail, Telefone, Região de Atuação, Pode mandar mensagem).\n");
}

$regioes = [];
$vinculos = [];
$pessoas_sql = [];
$usuarios_sql = [];

while (($row = fgetcsv($handle, 0, '|')) !== false) {
    $perfil_original = trim($row[$idx_perfil] ?? '');
    $nome     = addslashes(trim($row[$idx_nome] ?? ''));
    $email    = addslashes(trim($row[$idx_email] ?? ''));
    $telefone = addslashes(trim($row[$idx_telefone] ?? ''));
    $regiao   = trim($row[$idx_regiao] ?? '');
    $pode_msg = trim($row[$idx_manda_msg] ?? '');

    if ($nome === '' || $email === '') continue;

    // Mapeamento de perfis
    if ($perfil_original === 'Agentes Territoriais') {
        $perfil_final = 'Bolsista com Ação Territorial';
    } elseif ($perfil_original === 'Coordenação estadual') {
        $perfil_final = 'Bolsista para a Coordenação Estadual';
    } else {
        $perfil_final = $perfil_original;
    }

    $vinculos[$perfil_final] = true;
    $regioes[$regiao] = true;

    // Inserção em pessoas
    $pessoas_sql[] = "INSERT INTO pessoas (nome_pessoa, email, telefone, id_tipo_vinculo, id_regiao_atuacao) VALUES "
        . "('$nome', '$email', '$telefone', "
        . "(SELECT id_chave_tipo_vinculo FROM tipos_vinculos WHERE nome_tipo_vinculo = '$perfil_final'), "
        . "(SELECT id_chave_regiao_atuacao FROM regioes_atuacao WHERE nome_regiao_atuacao = '$regiao'));";

    // Geração do nome de usuário e hash
    $nome_usuario = explode('@', $email)[0];
    $nome_usuario = addslashes($nome_usuario);
    $hash = hash('sha256', 'agora_vai' . $nome_usuario);

    $usuarios_sql[] = "INSERT INTO usuarios (nome_usuario, senha, hash, data_inicio_cadastro, id_pessoa, pode_msg) VALUES "
        . "('$nome_usuario', '', '$hash', CURDATE(), "
        . "(SELECT id_chave_pessoa FROM pessoas WHERE email = '$email'), '$pode_msg');";
}
fclose($handle);

$out = fopen($outputFile, 'w');

// Tabela regioes_atuacao
fwrite($out, "-- (Re)criação da tabela regioes_atuacao\n");
fwrite($out, "DROP TABLE IF EXISTS regioes_atuacao;\n");
fwrite($out, "CREATE TABLE regioes_atuacao (\n");
fwrite($out, "  id_chave_regiao_atuacao INT AUTO_INCREMENT PRIMARY KEY,\n");
fwrite($out, "  nome_regiao_atuacao VARCHAR(255) UNIQUE\n");
fwrite($out, ") ENGINE=InnoDB;\n\n");

// Inserts regioes_atuacao
fwrite($out, "-- Inserts únicos em regioes_atuacao\n");
foreach (array_keys($regioes) as $regiao) {
    $regiao = addslashes($regiao);
    fwrite($out, "INSERT INTO regioes_atuacao (nome_regiao_atuacao) VALUES ('$regiao');\n");
}

// Inserts tipos_vinculos
fwrite($out, "\n-- Inserts em tipos_vinculos (para perfis do CSV)\n");
foreach (array_keys($vinculos) as $v) {
    $v = addslashes($v);
    fwrite($out, "INSERT IGNORE INTO tipos_vinculos (nome_tipo_vinculo, descricao) VALUES ('$v', 'Inserido automaticamente a partir do CSV');\n");
}

// Alterações na tabela pessoas
fwrite($out, "\n-- Alterações na tabela pessoas para incluir FKs\n");
fwrite($out, "ALTER TABLE pessoas\n");
fwrite($out, "  ADD COLUMN id_tipo_vinculo INT,\n");
fwrite($out, "  ADD COLUMN id_regiao_atuacao INT,\n");
fwrite($out, "  ADD CONSTRAINT fk_tipo_vinculo FOREIGN KEY (id_tipo_vinculo) REFERENCES tipos_vinculos(id_chave_tipo_vinculo),\n");
fwrite($out, "  ADD CONSTRAINT fk_regiao_atuacao FOREIGN KEY (id_regiao_atuacao) REFERENCES regioes_atuacao(id_chave_regiao_atuacao);\n");

// Inserts pessoas
fwrite($out, "\n-- Inserts na tabela pessoas\n");
foreach ($pessoas_sql as $sql) {
    fwrite($out, "$sql\n");
}

// Inserts usuarios
fwrite($out, "\n-- Inserts na tabela usuarios\n");
foreach ($usuarios_sql as $sql) {
    fwrite($out, "$sql\n");
}

fclose($out);
echo "✅ Script SQL gerado com sucesso em '$outputFile'.\n";

